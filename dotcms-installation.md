# dotCMS Installation

This guide will walk through installing dotCMS from scratch using current best practices. (CentOS)

* Installing dotCMS
* PostgreSQL Configuration
* dotCMS Configuration
* Apache Reverse-Proxy Configuration
* SSL Using Certbot
* Monit Monitoring

There is also a terminal [command reference](#sysreference) at the bottom of this document. [Workarounds &amp; Fixes](#dotworkarounds).

## Pre-Reqs

### DotCMS With JDK 8 and Utilities (reboot since there will be kernel updates)
```
yum -y install https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm
yum -y install epel-release
yum -y install certbot httpd mod_proxy_html mod_ssl wget curl nano htop mc iptables-services setroubleshoot setools ant java-1.8.0-openjdk.x86_64 java-1.8.0-openjdk-headless.x86_64 postgresql96 postgresql96-server monit
yum -y update
reboot
```

### Download DotCMS
```
mkdir -p /opt/dotcms && cd /opt/dotcms
wget http://dotcms.com/physical_downloads/release_builds/dotcms_4.3.3.tar.gz
```

### (Optional) dotCMS Empty Starter || Starter with Utilities
```
wget https://raw.githubusercontent.com/dotCMS/empty-starter/master/starter.zip
wget https://ngz.io/ethode/dotcms-starter/starter-plus-tools_0.31.zip
```

### Create dotCMS User and set password
```
groupadd dotcms
useradd -M -s /sbin/nologin dotcms -g dotcms
passwd dotcms
```

### PostgreSQL Config
```
/usr/pgsql-9.6/bin/postgresql96-setup initdb
systemctl enable postgresql-9.6
systemctl start postgresql-9.6
su postgres
psql
```

### PostgreSQL dotCMS User and Database 
```
CREATE USER dotcms WITH PASSWORD '****CHANGEME****';
CREATE DATABASE "dotcms" WITH OWNER = dotcms ENCODING = 'UTF8' TABLESPACE = pg_default LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8' CONNECTION LIMIT = -1;
GRANT ALL ON DATABASE "dotcms" TO dotcms;
ALTER ROLE dotcms WITH SUPERUSER;
```

#### MySQL/MariaDB Version
```
CREATE USER 'dotcms'@'localhost';
SET PASSWORD FOR 'dotcms'@'localhost' = PASSWORD('****CHANGEME****');
CREATE DATABASE `dotcms` DEFAULT CHARACTER SET = utf8 DEFAULT COLLATE = utf8_general_ci;
GRANT ALL PRIVILEGES ON `dotcms`.`*` TO 'dotcms'@'localhost';
```

### Edit PostgreSQL Connection Properties

`nano /var/lib/pgsql/9.6/data/pg_hba.conf`
```
host    all             all              127.0.0.1/32            password
```

### Restart PostgreSQL
`systemctl restart postgresql`

----

## dotCMS Installation

### Create Base Folder and Extract

```
cd /opt/dotcms
tar -zxvf dotcms_4.3.3.tar.gz
```

### Create PID Directory
```
mkdir /var/run/dotcms
chown dotcms:dotcms /var/run/dotcms
```

----

## dotCMS Configuration: Using Configuration and Root Folder Plugins

### Create Base Directories
```
mkdir -p plugins/com.dotcms.config/ROOT/bin
mkdir -p plugins/com.dotcms.config/ROOT/dotserver/tomcat-8.0.18/webapps/ROOT/META-INF
mkdir -p plugins/com.dotcms.config/ROOT/dotserver/tomcat-8.0.18/conf/
mkdir -p plugins/com.dotcms.config/ROOT/dotserver/tomcat-8.0.18/webapps/ROOT/WEB-INF/classes
```

### Copy Vanilla Configs
```
cp dotserver/tomcat-8.0.18/webapps/ROOT/META-INF/context.xml plugins/com.dotcms.config/ROOT/dotserver/tomcat-8.0.18/webapps/ROOT/META-INF
cp dotserver/tomcat-8.0.18/conf/server.xml plugins/com.dotcms.config/ROOT/dotserver/tomcat-8.0.18/conf
cp bin/startup.sh plugins/com.dotcms.config/ROOT/bin
```

### Configure Database Connector
`nano plugins/com.dotcms.config/ROOT/dotserver/tomcat-8.0.18/webapps/ROOT/META-INF/context.xml`
```
<Resource name="jdbc/dotCMSPool" auth="Container"
      type="javax.sql.DataSource"
      factory="org.apache.tomcat.jdbc.pool.DataSourceFactory"
      driverClassName="org.postgresql.Driver"
      url="jdbc:postgresql://localhost/dotcms"
      username="dotcms" password="****CHANGEME****" maxTotal="60" maxIdle="10" maxWaitMillis="60000"
      removeAbandonedOnBorrow="true" removeAbandonedOnMaintenance="true" removeAbandonedTimeout="60" logAbandoned="true"
      timeBetweenEvictionRunsMillis="30000" validationQuery="SELECT 1" testOnBorrow="true" testWhileIdle="true" />
```

### Require SSL for everything (Skip if not using SSL)
`nano plugins/com.dotcms.config/ROOT/dotserver/tomcat-8.0.18/conf/server.xml`
```
<Connector port="8080" protocol="HTTP/1.1"
    connectionTimeout="20000"
    redirectPort="8443" URIEncoding="UTF-8"
    secure="true" proxyPort="443" scheme="https" />
```

#### Alternate: Use AJP
```
<Connector port="8009" protocol="AJP/1.3" redirectPort="8443" />
```

### (Optional) Custom starter
```
mv dotserver/tomcat-8.0.18/webapps/ROOT/starter.zip dotserver/tomcat-8.0.18/webapps/ROOT/starter-vanilla.zip
mv starter-plus-tools_0.31.zip plugins/com.dotcms.config/ROOT/dotserver/tomcat-8.0.18/webapps/ROOT
```

`nano plugins/com.dotcms.config/conf/dotmarketing-config-ext.properties`

```
STARTER_DATA_LOAD=/starter-plus-tools_0.31.zip
```
[Custom Starter: More Information](https://dotcms.com/docs/latest/deploying-a-custom-starter-site)

### Give dotCMS more RAM and set PID File
`nano plugins/com.dotcms.config/ROOT/bin/startup.sh`
```
-Xmx4G
```
[Memory Config: More Information](https://dotcms.com/docs/latest/memory-configuration)

```
export CATALINA_PID="/var/run/dotcms/$DOTSERVER.pid"
```

### (Optional/Recommended) Change location of assets directory
`mkdir /opt/dotcms-assets`

`nano plugins/com.dotcms.config/conf/dotmarketing-config-ext.properties`
```
ASSET_REAL_PATH=/opt/dotcms-assets
```
[More Information](https://dotcms.com/docs/latest/asset-storage)

### Cache tuning
`nano plugins/com.dotcms.config/conf/dotmarketing-config-ext.properties`
```
cache.blockdirectivecache.size=3600
cache.categoryparentscache.size=90000
cache.foldercache.size=6000
cache.htmlpagecache.size=24000
cache.identifier404cache.size=3000
cache.rulescache.size=5000
cache.tagsbyinodecache.size=4000
cache.velocitycache.size=5000
cache.virtuallinkscache.size=3500
```
[More Information: Caching](https://dotcms.com/docs/latest/cache-configuration)

[More Information: Guava Cache](https://dotcms.com/docs/latest/guava-cache-provider)

### Make dotcms owner
`chown -R dotcms:dotcms /opt/dotcms`

### Set JAVA_HOME (applies globally)

`nano /etc/profile.d/java_home.sh`
```
export JAVA_HOME=/usr/lib/jvm/jre-openjdk
```

(Logout and back in)

### Commit Changes, deploy plugin
`/opt/dotcms/bin/deploy-plugins.sh`

### To Make further changes
1. `cd /opt/dotcms`
1. `bin/undeploy-plugins.sh`
1. Make changes.
1. `bin/deploy-plugins.sh`

[More Information](https://dotcms.com/docs/latest/changing-dotcms-configuration-properties)

----

## Setup dotCMS as a service

### Create systemd config
`nano /etc/sysconfig/dotcms`
```
JAVA_HOME=/usr/lib/jvm/jre-openjdk
CATALINA_PID=/var/run/dotcms/dotserver.pid
DOTCMS_HOME=/opt/dotcms
```

### Create Unit File
`nano /usr/lib/systemd/system/dotcms.service`
```
[Unit]
Description=dotCMS Service
After=network.target

[Service]
Type=forking
EnvironmentFile=/etc/sysconfig/dotcms
WorkingDirectory=/opt/dotcms
PIDFile=/var/run/dotcms/dotserver.pid
User=dotcms
Group=dotcms
KillMode=none
ExecStart=/opt/dotcms/bin/startup.sh
ExecStop=/opt/dotcms/bin/shutdown.sh

[Install]
WantedBy=multi-user.target
```

### Fire it up
```
systemctl enable dotcms
systemctl start dotcms
```

[More Information](https://www.digitalocean.com/community/tutorials/understanding-systemd-units-and-unit-files)

----

# View Logs
```
tail -fn200 /opt/dotcms/dotserver/tomcat-8.0.18/logs/catalina.out
tail -fn200 /opt/dotcms/dotserver/tomcat-8.0.18/webapps/ROOT/dotsecure/logs/dotcms.log
```

## Configure Apache
`nano /etc/httpd/conf.d/dotcms.conf`
```
##########################
## Proxy to dotCMS:8080 ##
##########################
<IfModule mod_proxy_http.c>
<VirtualHost *:80>
    ServerName example.com
    ServerAdmin support@ethode.com

    ErrorLog /var/log/httpd/error.log
    CustomLog /var/log/httpd/access.log combined

    ProxyRequests Off
    ProxyPreserveHost On
    ProxyVia On
    ProxyPass / http://localhost:8080/ retry=0 acquire=3000 timeout=1200 Keepalive=On
    ProxyPassReverse / http://localhost:8080/ retry=0
    ### Alternate for AJP
    #ProxyPass / ajp://localhost:8009/ retry=0 acquire=3000 timeout=1200 Keepalive=On
    #ProxyPassReverse / ajp://localhost:8009/ retry=0
    <Proxy *>
        Order deny,allow
        Allow from all
    </Proxy>

    ## Redirect to https
    <IfModule mod_ssl.c>
        RewriteEngine on
        RewriteCond %{SERVER_NAME} =example.com
        RewriteRule ^ https://%{SERVER_NAME}%{REQUEST_URI} [END,NE,R=permanent]
    </IfModule>
</VirtualHost>
</IfModule>
```

SSL 

```
#########################
## Proxy to dotCMS SSL ##
#########################
<IfModule mod_ssl.c>
<VirtualHost *:443>
    ServerName example.com
    ServerAdmin support@ethode.com
    
    ErrorLog /var/log/httpd/error.log
    CustomLog /var/log/httpd/access.log combined
    
    ProxyRequests Off
    ProxyPreserveHost On
    ProxyVia On
    ProxyPass         / http://localhost:8080/ retry=0 acquire=3000 timeout=1200 Keepalive=On
    ProxyPassReverse  / http://localhost:8080/ retry=0
    ### Alternate for AJP
    #ProxyPass         / ajp://localhost:8009/ retry=0 acquire=3000 timeout=1200 Keepalive=On
    #ProxyPassReverse  / ajp://localhost:8009/ retry=0
    
    <Proxy *>
    	Order deny,allow
    	Allow from all
    </Proxy>
    
    Include /etc/letsencrypt/options-ssl-apache.conf
    SSLCertificateFile /etc/letsencrypt/live/example.com/cert.pem
    SSLCertificateKeyFile /etc/letsencrypt/live/example.com/privkey.pem
    SSLCertificateChainFile /etc/letsencrypt/live/example.com/chain.pem
</VirtualHost>
</IfModule>
```

### Allow Apache to access local network for reverse proxy
`setsebool -P httpd_can_network_connect 1`

### Certbot webroot authentication
`certbot certonly --webroot -w /opt/dotcms/dotserver/tomcat-8.0.18/webapps/ROOT -d domain.com`
or
`certbot --apache`

[More information](https://certbot.eff.org/docs/using.html)

### Automate Certificate Renewal (Every 5 Days, log to file)
`crontab -e`
```
* * */5 * * /root/certbot-auto renew > /var/log/letsencrypt-autorenew.log
```

----

## Setup Monit

### (Configure for M/Monit)
`nano /etc/monitrc`
```
set eventqueue
set mmonit http://username:password@mmonithost.tld:8081/collector
```

Go to config directory: `cd /etc/monit.d`

### Get configs for dotCMS and Apache
```
wget https://raw.githubusercontent.com/x0rsw1tch/monit-presets/master/dotcms.conf
wget https://raw.githubusercontent.com/x0rsw1tch/monit-presets/master/httpd.conf
```

[More Configs](https://github.com/x0rsw1tch/monit-presets)

----

# <a name="sysreference"></a> References

## Useful Commands: System
```
systemctl enable iptables                       ## Use iptables. Disable firewalld first!
iptables -A INPUT -p tcp --dport 80 -j ACCEPT   ## Allow communication on incoming port
service iptables save                           ## Save iptables config
systemctl daemon-reload                         ## Reload systemd unit files (When making changes)
```

## Useful Commands: SELinux
```
setenforce Permissive                          ## Put SELinux in Permissive mode (Throw warnings instead of denial)
setsebool -P httpd_can_network_connect 1       ## Allow Apache to connect to local host (reverse proxy)
setsebool -P httpd_can_network_connect_db 1    ## Allow Apache to connect to DB over TCP
setsebool -P httpd_use_cifs 1                  ## Allow Apache to host in samba context
setsebool -P ssh_chroot_rw_homedirs 1          ## Allow chrooted ssh to read write to home
semanage boolean -l                            ## List Booleans
getsebool -a                                   ## List Booleans with explanation
semanage fcontext -a -t context_name /path     ## Change security context, accepts wildcards
restorecon -v /path                            ## Commits change from fcontext, Use -r for recursive
ls -aZ                                         ## View dir with context column
semanage login -l                              ## Show user contexts
ps -eZ                                         ## Show processes with contexts
tail -f -n100 /var/log/audit/audit.log         ## SELinux Log
aureport -a                                    ## Show SELinux audit summary
seinfo -r                                      ## Show SELinux roles
```

# <a name="dotworkarounds"></a> Workarounds

## Fix for missing default workflow (until dotCMS fixes this)

> Only do this after dotCMS is deployed and running. No need to restart dotCMS

As Root: `su postgres`

`psql`

```
INSERT INTO workflow_scheme (id, name, description, archived, mandatory, default_scheme, entry_action_id, mod_date) VALUES ('85c1515c-c4f3-463c-bac2-860b8fcacc34','Default Scheme','This is the default workflow scheme that will be applied to all content',null,null,'t',null,null);
INSERT INTO workflow_step (id, name, scheme_id, my_order, resolved, escalation_enable, escalation_action, escalation_time) VALUES ('f7dc56cd-aa81-4ca8-8174-1bb30756df82','Initial State','85c1515c-c4f3-463c-bac2-860b8fcacc34','0','t','f',null,'0');
INSERT INTO workflow_step (id, name, scheme_id, my_order, resolved, escalation_enable, escalation_action, escalation_time) VALUES ('43e16aac-5799-46d0-945c-83753af39426','Content Entry','85c1515c-c4f3-463c-bac2-860b8fcacc34','1','f','f',null,'0');
INSERT INTO workflow_step (id, name, scheme_id, my_order, resolved, escalation_enable, escalation_action, escalation_time) VALUES ('b1246a0f-6d15-47aa-81bb-67919a6946e0','Closed','85c1515c-c4f3-463c-bac2-860b8fcacc34','2','t','f',null,'0');
```