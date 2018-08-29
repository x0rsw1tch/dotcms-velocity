#!/bin/sh
## cd to / to avoid access denied to /root when sudo'ing
cd /

if [[ "$(whoami)" != "root" ]] ; then
	echo ""
	echo "Must be root"
	echo ""
	exit 1
fi

if [[ -z "$1" ]]; then
echo "Usage: install-dotcms-unattended.sh domain.com"
exit 1
fi


##
## Settings
##

HTTP_DOMAIN_NAME="$1"

## Passwords. Kudos to earthgecko/bash.generate.random.alphanumeric.string.sh
DOTCMS_USER_LINUX_PASSWORD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
DOTCMS_DATABASE_PASSWORD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)

## PostgresSQL
PREREQUISITE_PACKAGE_LIST_STEP_ONE="epel-release"
PREREQUISITE_PACKAGE_LIST_STEP_TWO="httpd wget curl nano htop mc iptables-services java-1.8.0-openjdk java-1.8.0-openjdk-headless nmap lsof certbot mod_proxy_html mod_ssl ant monit"

POSTGRESQL_RPM="https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm"
POSTGRESQL_PACKAGES="postgresql96 postgresql96-server"
POSTGRESQL_VERSION="9.6"
POSTGRESQL_INIT_BIN="postgresql96-setup"

POSTGRESQL_HBACONF_PATH="/var/lib/pgsql/${POSTGRESQL_VERSION}/data/pg_hba.conf"

## Users
DOTCMS_LINUX_USER="dotcms"
DOTCMS_LINUX_GROUP="dotcms"
DOTCMS_DATABASE_USER="dotcms"
DOTCMS_DATABASE_NAME="dotcms"

## dotCMS Install
DOTCMS_INSTALL_VERSION="5.0.1"
DOTCMS_TOMCAT_VERSION="8.5.32"

## dotCMS Config
DOTCMS_TOMCAT_USE_SSL=true
DOTCMS_USE_FAT_CACHES=true
DOTCMS_JAVA_XMX="4G"
DOTCMS_PID_DIRECTORY="/var/run/dotcms"
DOTCMS_PID_FILE="dotcms.pid"
DOTCMS_USE_TOOLS=true
DOTCMS_USE_MINIMAL=true
DOTCMS_STARTER_FILE="dotcms-${DOTCMS_INSTALL_VERSION}_minimal.zip"
DOTCMS_DISABLE_CLUSTER_AUTO_WIRE=true
DOTCMS_CONFIGURE_SYSTEMD=true

## Monit
MONIT_CONFIGURE=true

## Apache
APACHE_CONFIG=true


echo ""
echo ""
echo "################################################################################"
echo "#                     dotCMS Unattended Installer v0.1                         #"
echo "#                           CentOS 7.2 Edition                                 #"
echo "#                                                                              #"
echo "#                 An automated script with one confirmation                    #"
echo "#                                                                              #"
echo "################################################################################"
echo "#                                                                              #"
echo "#                               Procedure                                      #"
echo "# 1. Confirm Settings                                                          #"
echo "# 2. Install PostgresSQL                                                       #"
echo "# 3. Install Prerequisites                                                     #"
echo "# 4. Configuration                                                             #"
echo "# 5. Installation / Verification                                               #"
echo "#                                                                              #"
echo "################################################################################"
echo ""
echo ""
echo "################################################################################"
echo "#                          Settings Confirmation                               #"
echo "################################################################################"
echo ""
echo "############################## Linux Packages ##################################"
echo ""
echo "${POSTGRESQL_PACKAGES}"
echo "${PREREQUISITE_PACKAGE_LIST_STEP_ONE}"
echo "${PREREQUISITE_PACKAGE_LIST_STEP_TWO}"
echo ""
echo "################################################################################"
echo ""
echo "** Passwords will be provided at the end of the script"
echo ""
echo "dotCMS:"
echo "         Version to Install: ${DOTCMS_INSTALL_VERSION}"
echo "          Configure systemd: ${DOTCMS_CONFIGURE_SYSTEMD}"
echo ""
echo ""
echo "PostgresSQL:"
echo "         Version to Install: ${POSTGRESQL_VERSION}"
echo ""
echo "Users/DB:"
echo "          dotCMS Linux User: ${DOTCMS_LINUX_USER}"
echo "    dotCMS PostgresSQL User: ${DOTCMS_DATABASE_USER}"
echo "  PostgresSQL Database Name: ${DOTCMS_DATABASE_NAME}"
echo ""
echo "dotCMS Config:"
echo "              PID Directory: ${DOTCMS_PID_DIRECTORY}"
echo "                   PID File: ${DOTCMS_PID_FILE}"
echo "          Tomcat SSL Schema: ${DOTCMS_TOMCAT_USE_SSL}"
echo "    Minimal Starter Package: ${DOTCMS_USE_MINIMAL}"
echo "          Install Utilities: ${DOTCMS_USE_TOOLS}"
echo "                   Java Xmx: ${DOTCMS_JAVA_XMX}"
echo "             Use fat caches: ${DOTCMS_USE_FAT_CACHES}"
echo "  Disable Cluster auto-wire: ${DOTCMS_DISABLE_CLUSTER_AUTO_WIRE}"
echo ""
echo "Apache:"
echo "  VirtualHost/Reverse Proxy: ${APACHE_CONFIG}"
echo ""
echo "Monit:"
echo "   Configure Monit Monitors: ${MONIT_CONFIGURE}"
echo ""
echo ""

echo "*** WARNING: Operating System must be up to date!"

read -p "Is this ok? [y/n]: " -r INSTALL_CONTINUE
echo ""

if [[ $INSTALL_CONTINUE =~ ^[Nn]$ ]] ; then
echo ""
echo "Please adjust script configuration before running again."
echo ""
exit 1
fi

if [[ -z "$HTTP_DOMAIN_NAME" ]]; then
read -p "Domain name: " -r HTTP_DOMAIN_NAME
fi
echo ""
echo ""
echo "################################################################################"
echo "#                         Installing PostgresSQL                               #"
echo "################################################################################"
echo ""

echo ""
yum -y install ${POSTGRESQL_RPM}
yum -y install ${POSTGRESQL_PACKAGES}
echo ""
echo ""
echo "################################################################################"
echo "#                    Installing Prerequisite Packages                          #"
echo "################################################################################"
echo ""

echo ""
yum -y install ${PREREQUISITE_PACKAGE_LIST_STEP_ONE}
yum -y install ${PREREQUISITE_PACKAGE_LIST_STEP_TWO}
echo ""
echo ""
echo "################################################################################"
echo "#                           Creating dotCMS User                               #"
echo "################################################################################"
echo ""

echo ""
groupadd ${DOTCMS_LINUX_GROUP}
useradd -M ${DOTCMS_LINUX_USER} -g ${DOTCMS_LINUX_GROUP}
echo "dotcms:${DOTCMS_USER_LINUX_PASSWORD}" | chpasswd
echo ""
echo ""
echo "################################################################################"
echo "#                          Configure PostgresSQL                               #"
echo "################################################################################"
echo ""

echo ""
echo "Initialize DB and start Server..."
echo ""
/usr/pgsql-${POSTGRESQL_VERSION}/bin/${POSTGRESQL_INIT_BIN} initdb
systemctl enable postgresql-9.6
systemctl start postgresql-9.6

echo ""
echo "Create Database..."
echo ""
sudo -u postgres psql -c "CREATE USER dotcms WITH PASSWORD '${DOTCMS_DATABASE_PASSWORD}';"
sudo -u postgres psql -c "CREATE DATABASE \"dotcms\" WITH OWNER = dotcms ENCODING = 'UTF8' TABLESPACE = pg_default LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8' CONNECTION LIMIT = -1;"
sudo -u postgres psql -c "GRANT ALL ON DATABASE \"dotcms\" TO dotcms;"

echo ""
echo "Edit connection configuration..."
echo ""
sed -i '/host    all             all             127.0.0.1\/32            md5/c host    all             all             127.0.0.1\/32            password' ${POSTGRESQL_HBACONF_PATH}

echo ""
echo "Restart Server..."
echo ""
systemctl restart postgresql-9.6
echo ""
echo ""
echo "################################################################################"
echo "#                              Install dotCMS                                  #"
echo "################################################################################"
echo ""

echo ""
echo "Making PID Directory..."
echo ""
mkdir -p ${DOTCMS_PID_DIRECTORY}
chown dotcms:dotcms ${DOTCMS_PID_DIRECTORY}

echo ""
echo "Making /opt/dotcms..."
echo ""
mkdir -p /opt/dotcms
cd /opt/dotcms

echo ""
echo "Download dotCMS..."
echo ""
wget http://dotcms.com/physical_downloads/release_builds/dotcms_${DOTCMS_INSTALL_VERSION}.tar.gz

if [[ $DOTCMS_USE_MINIMAL = true ]] ; then
echo ""
echo "Download Starter..."
echo ""
wget https://raw.githubusercontent.com/x0rsw1tch/dotcms-starters/master/dotcms-${DOTCMS_INSTALL_VERSION}_minimal.zip
fi

if [[ $DOTCMS_USE_TOOLS = true ]] ; then
echo ""
echo "Download Management Tools..."
echo ""
wget https://raw.githubusercontent.com/x0rsw1tch/dotTools/master/dottools.tar.gz
mkdir -p plugins/com.dotcms.config/ROOT/dotserver/tomcat-${DOTCMS_TOMCAT_VERSION}/webapps/ROOT/dottools
tar -zxvf dottools.tar.gz -C plugins/com.dotcms.config/ROOT/dotserver/tomcat-${DOTCMS_TOMCAT_VERSION}/webapps/ROOT/dottools
fi

echo ""
echo "Unpacking dotCMS..."
echo ""
tar -zxvf dotcms_${DOTCMS_INSTALL_VERSION}.tar.gz

echo ""
echo ""
echo "################################################################################"
echo "#                             Configure dotCMS                                 #"
echo "################################################################################"
echo ""
echo ""

echo ""
echo 'Making plugin folders...'
echo ""
mkdir -p plugins/com.dotcms.config/ROOT/bin
mkdir -p plugins/com.dotcms.config/ROOT/dotserver/tomcat-${DOTCMS_TOMCAT_VERSION}/webapps/ROOT/META-INF
mkdir -p plugins/com.dotcms.config/ROOT/dotserver/tomcat-${DOTCMS_TOMCAT_VERSION}/conf/
mkdir -p plugins/com.dotcms.config/ROOT/dotserver/tomcat-${DOTCMS_TOMCAT_VERSION}/webapps/ROOT/WEB-INF/classes

echo ""
echo 'Copying config files...'
echo ""
cp dotserver/tomcat-${DOTCMS_TOMCAT_VERSION}/webapps/ROOT/META-INF/context.xml plugins/com.dotcms.config/ROOT/dotserver/tomcat-${DOTCMS_TOMCAT_VERSION}/webapps/ROOT/META-INF
cp dotserver/tomcat-${DOTCMS_TOMCAT_VERSION}/conf/server.xml plugins/com.dotcms.config/ROOT/dotserver/tomcat-${DOTCMS_TOMCAT_VERSION}/conf
cp bin/startup.sh plugins/com.dotcms.config/ROOT/bin

echo ""
echo 'Editing context.xml...'
echo ""
sed -i "/<!-- H2-->/c \ \ \ \ <\!-- SECTION EDITED WITH DOTCMS INSTALLER -->\n\ \ \ \ <!-- H2" plugins/com.dotcms.config/ROOT/dotserver/tomcat-${DOTCMS_TOMCAT_VERSION}/webapps/ROOT/META-INF/context.xml
sed -i "0,/abandonWhenPercentageFull=\"50\"\/>/s/abandonWhenPercentageFull=\"50\"\/>/abandonWhenPercentageFull=\"50\"\/>\n\ \ \ \ -->/" plugins/com.dotcms.config/ROOT/dotserver/tomcat-${DOTCMS_TOMCAT_VERSION}/webapps/ROOT/META-INF/context.xml
sed -i "/<!-- POSTGRESQL/c \ \ \ \ <\!-- SECTION EDITED WITH DOTCMS INSTALLER -->\n\ \ \ \ <!-- POSTGRESQL -->" plugins/com.dotcms.config/ROOT/dotserver/tomcat-${DOTCMS_TOMCAT_VERSION}/webapps/ROOT/META-INF/context.xml
sed -i "/url=\"jdbc\:postgresql\:\/\/localhost\/dotcms\"/c \ \ \ \ \ \ \ \ \ \ url=\"jdbc\:postgresql\:\/\/localhost\/${DOTCMS_DATABASE_NAME}\"" plugins/com.dotcms.config/ROOT/dotserver/tomcat-${DOTCMS_TOMCAT_VERSION}/webapps/ROOT/META-INF/context.xml
sed -i "/username=\"{your db user}\" password=\"{your db password}\"/c \ \ \ \ \ \ \ \ \ \ username=\"${DOTCMS_DATABASE_USER}\" password=\"${DOTCMS_DATABASE_PASSWORD}\" maxActive=\"60\" maxIdle=\"10\" maxWait=\"60000\"" plugins/com.dotcms.config/ROOT/dotserver/tomcat-${DOTCMS_TOMCAT_VERSION}/webapps/ROOT/META-INF/context.xml
sed -i '0,/^-->$/s/^-->$//'  plugins/com.dotcms.config/ROOT/dotserver/tomcat-${DOTCMS_TOMCAT_VERSION}/webapps/ROOT/META-INF/context.xml


if [[ $DOTCMS_TOMCAT_USE_SSL = true ]] ; then
echo ""
echo 'Editing server.xml: SSL config...'
echo ""
sed -i '/redirectPort=\"8443\" URIEncoding=\"UTF-8\"\/>/c \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ redirectPort=\"8443\" URIEncoding=\"UTF-8\"\n\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ secure=\"true\" proxyPort=\"443\" scheme=\"https\"\/>' plugins/com.dotcms.config/ROOT/dotserver/tomcat-${DOTCMS_TOMCAT_VERSION}/conf/server.xml
fi

if [[ $DOTCMS_USE_MINIMAL = true ]] ; then
echo ""
echo "Adding Custom Starter..."
echo ""
mv dotserver/tomcat-${DOTCMS_TOMCAT_VERSION}/webapps/ROOT/starter.zip dotserver/tomcat-${DOTCMS_TOMCAT_VERSION}/webapps/ROOT/starter-vanilla.zip
mv ${DOTCMS_STARTER_FILE} plugins/com.dotcms.config/ROOT/dotserver/tomcat-${DOTCMS_TOMCAT_VERSION}/webapps/ROOT
echo "STARTER_DATA_LOAD=/${DOTCMS_STARTER_FILE}" >> plugins/com.dotcms.config/conf/dotmarketing-config-ext.properties
fi

echo ""
echo "Editing Startup script..."
echo ""
sed -i "/JAVA_OPTS=\"\$JAVA_OPTS -XX\:MaxMetaspaceSize=512m -Xmx1G\"/c JAVA_OPTS=\"\$JAVA_OPTS -XX\:MaxMetaspaceSize=512m -Xmx${DOTCMS_JAVA_XMX}\""  plugins/com.dotcms.config/ROOT/bin/startup.sh
sed -i '/export CATALINA_PID=\"\/tmp\/\$DOTSERVER\.pid\"/c \ \ \ \ \ \ \ \ export CATALINA_PID=\"${DOTCMS_PID_DIRECTORY}\/${DOTCMS_PID_FILE}\"'  plugins/com.dotcms.config/ROOT/bin/startup.sh

if [[ $DOTCMS_USE_FAT_CACHES = true ]] ; then
echo ""
echo "Adding fat caches..."
echo ""
cat << EOF >> plugins/com.dotcms.config/conf/dotmarketing-config-ext.properties
cache.blockdirectivecache.size=3600
cache.categoryparentscache.size=90000
cache.foldercache.size=6000
cache.htmlpagecache.size=24000
cache.identifier404cache.size=3000
cache.rulescache.size=5000
cache.tagsbyinodecache.size=4000
cache.velocitycache.size=5000
cache.virtuallinkscache.size=3500
EOF
fi

if [[ $DOTCMS_DISABLE_CLUSTER_AUTO_WIRE = true ]] ; then
echo ""
echo "Disabling cluster auto-wire..."
echo ""
cat << EOF >> plugins/com.dotcms.config/conf/dotcms-config-cluster-ext.properties
AUTOWIRE_CLUSTER_TRANSPORT=false
AUTOWIRE_CLUSTER_ES=false
DIST_INDEXATION_ENABLED=true
EOF
fi

echo ""
echo "Setting JAVA_HOME..."
echo ""
touch /etc/profile.d/java_home.sh
echo "export JAVA_HOME=/usr/lib/jvm/jre-openjdk" > /etc/profile.d/java_home.sh

echo ""
echo "Making dotcms owner..."
echo ""
chown -R dotcms:dotcms /opt/dotcms


if [[ $DOTCMS_CONFIGURE_SYSTEMD = true ]] ; then
echo ""
echo "Setting up dotCMS as a system service..."
echo ""

touch /etc/sysconfig/dotcms
cat << EOF > /etc/sysconfig/dotcms
JAVA_HOME=/usr/lib/jvm/jre-openjdk
CATALINA_PID=${DOTCMS_PID_DIRECTORY}/${DOTCMS_PID_FILE}
DOTCMS_HOME=/opt/dotcms
EOF

touch /usr/lib/systemd/system/dotcms.service
cat << EOF > /usr/lib/systemd/system/dotcms.service
[Unit]
Description=dotCMS Service
After=network.target

[Service]
Type=forking
EnvironmentFile=/etc/sysconfig/dotcms
WorkingDirectory=/opt/dotcms
PIDFile=${DOTCMS_PID_DIRECTORY}/${DOTCMS_PID_FILE}
User=dotcms
Group=dotcms
KillMode=none
ExecStart=/opt/dotcms/bin/startup.sh
ExecStop=/opt/dotcms/bin/shutdown.sh

[Install]
WantedBy=multi-user.target
EOF
fi

systemctl enable dotcms
setsebool -P httpd_can_network_connect 1

if [[ $APACHE_CONFIG = true ]] ; then
echo ""
echo "Configure Apache..."
echo ""

touch /etc/httpd/conf.d/dotcms.conf
cat << EOF > /etc/httpd/conf.d/dotcms.conf
##########################
## Proxy to dotCMS:8080 ##
##########################
<IfModule mod_proxy_http.c>
<VirtualHost *:80>
	ServerName ${HTTP_DOMAIN_NAME}
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
	#<IfModule mod_ssl.c>
	#    RewriteEngine on
	#    RewriteCond %{SERVER_NAME} ${HTTP_DOMAIN_NAME}
	#    RewriteRule ^ https://%{SERVER_NAME}%{REQUEST_URI} [END,NE,R=permanent]
	#</IfModule>
</VirtualHost>
</IfModule>
EOF

echo ""
echo "Enabling and Starting Apache..."
echo ""
systemctl enable httpd
systemctl start httpd

fi

if [[ $MONIT_CONFIGURE = true ]] ; then
echo ""
echo "Configuring monit..."
echo ""
systemctl enable monit
systemctl stop monit
wget -O /etc/monit.d/dotcms.conf https://raw.githubusercontent.com/x0rsw1tch/monit-presets/master/dotcms.conf
wget -O /etc/monit.d/httpd.conf https://raw.githubusercontent.com/x0rsw1tch/monit-presets/master/httpd.conf
systemctl start monit
fi

if [[ $DEPLOY_DOTCMS_STATIC_PLUGIN = true ]] ; then
echo ""
echo "Deploying Plugin..."
echo ""
export JAVA_HOME=/usr/lib/jvm/jre-openjdk
sudo -u dotcms bin/deploy-plugins.sh
fi

echo ""
echo ""
echo "################################################################################"
echo "#                                 Summary                                      #"
echo "################################################################################"
echo ""
echo ""
echo ""
echo "PostgresSQL:"
echo " Connection Config: ${POSTGRESQL_HBACONF_PATH}"
echo "     Database Name: ${DOTCMS_DATABASE_NAME}"
echo "       DB Password: ${DOTCMS_DATABASE_PASSWORD}"
echo ""
echo "Linux User:"
echo "          Username: ${DOTCMS_LINUX_USER}"
echo "          Password: ${DOTCMS_USER_LINUX_PASSWORD}"
echo ""
echo "dotCMS:"
echo "       context.xml: plugins/com.dotcms.config/ROOT/dotserver/tomcat-${DOTCMS_TOMCAT_VERSION}/webapps/ROOT/META-INF/context.xml"
echo "        server.xml: plugins/com.dotcms.config/ROOT/dotserver/tomcat-${DOTCMS_TOMCAT_VERSION}/conf/server.xml"
echo "            Config: plugins/com.dotcms.config/conf/dotmarketing-config-ext.properties"
echo "    Cluster Config: plugins/com.dotcms.config/dotcms-config-cluster-ext.properties"
echo "    Startup Script: plugins/com.dotcms.config/ROOT/bin/startup.sh"
echo "          PID File: ${DOTCMS_PID_DIRECTORY}/${DOTCMS_PID_FILE}"
echo "          Log File: /opt/dotcms/dotserver/tomcat-${DOTCMS_TOMCAT_VERSION}/logs/catalina.out"


echo << EOF >> dotcms-install.log
Install Summary:


PostgresSQL
----------------
Connection Config: ${POSTGRESQL_HBACONF_PATH}
Database Name:     ${DOTCMS_DATABASE_NAME}
DB Password:       ${DOTCMS_DATABASE_PASSWORD}

Linux User
----------------
Username: ${DOTCMS_DATABASE_PASSWORD}
Password: ${DOTCMS_USER_LINUX_PASSWORD}

dotCMS
----------------
context.xml: plugins/com.dotcms.config/ROOT/dotserver/tomcat-${DOTCMS_TOMCAT_VERSION}/webapps/ROOT/META-INF/context.xml
server.xml: plugins/com.dotcms.config/ROOT/dotserver/tomcat-${DOTCMS_TOMCAT_VERSION}/conf/server.xml
Config: plugins/com.dotcms.config/conf/dotmarketing-config-ext.properties
Cluster Config: plugins/com.dotcms.config/dotcms-config-cluster-ext.properties
Startup Script: plugins/com.dotcms.config/ROOT/bin/startup.sh
PID File: ${DOTCMS_PID_DIRECTORY}/${DOTCMS_PID_FILE}
Log File: /opt/dotcms/dotserver/tomcat-${DOTCMS_TOMCAT_VERSION}/logs/catalina.out
EOF

if [[ $DOTCMS_CONFIGURE_SYSTEMD = true ]] ; then
echo ""
echo "systemd:"
echo "          Env File: /etc/sysconfig/dotcms"
echo "         Unit File: /usr/lib/systemd/system/dotcms.service"
fi

if [[ $APACHE_CONFIG = true ]] ; then
echo ""
echo "Apache:"
echo "     dotCMS Config: /etc/httpd/conf.d/dotcms.conf"
fi

if [[ $MONIT_CONFIGURE = true ]] ; then
echo ""
echo "Monit:"
echo "             httpd: /etc/monit.d/dotcms.conf"
echo "            dotcms: /etc/monit.d/httpd.conf"
fi

echo ""
echo "################################################################################"
echo ""

echo ""
echo ""
echo "################################################################################"
echo "#                                  Notes                                       #"
echo "################################################################################"
echo ""
echo "*** Verify Configs:"
echo ""
echo "Please refer to configuration file locations and verify the replacements are accurate."
echo ""
echo "*** Check catalina.out:"
echo ""
echo "If there are any issues with the OOB configuration, the logs should tell you where the"
echo "problems are located. This shouldn't be an issue, unless dotCMS decides to change the"
echo "file structure, or move things around."
echo ""

echo "*** To install SSL Certs with Certbot:"
echo ""
echo "wget https://dl.eff.org/certbot-auto"
echo "chmod a+x ./certbot-auto"
echo "certbot-auto run -a webroot -i apache -w /opt/dotcms/dotserver/tomcat-${DOTCMS_TOMCAT_VERSION}/webapps/ROOT -d ${HTTP_DOMAIN_NAME}"
echo "... or ..."
echo "certbot-auto --apache"
