## Installation Pre-Reqs and misc utilities
### DotCMS 3.x With OpenJDK 8
`sudo yum -y update`
`sudo yum -y install ethtool wget curl nano java-1.8.0-openjdk.x86_64 java-1.8.0-openjdk-headless.x86_64 postgresql.x86_64 postgresql-server.x86_64 mc`

---

### Disable SELinux
`sudo setenforce 0`
#### OR
`sudo nano /etc/sysconfig/selinux`<br>
~~`SELINUX=permissive`~~<br>
`SELINUX=disabled`
#### THEN
`sudo nano /boot/grub/grub.conf`
#### ADD to end of kernel line
`selinux=0`
#### THEN
`grub-update`
#### Reboot


##### NOTE: If you know how to get dotCMS to play nicely with SELinux, then go for it

### Disable RedHat Firewall Daemon
`sudo systemctl stop firewalld`<br>
`sudo systemctl disable firewalld`

### Setup IPTables to reroute port 8080 to 80 (Is not persistent across reboots, need to find perm solution)
`sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080`

### Fix OpenStack/CentOS speed problems
`sudo ethtool -K eth0 tso off gro off`

#### Or make above fix permanent
`sudo su -`
`echo "/sbin/ethtool -K eth0 tso off gro off" > /etc/NetworkManager/dispatcher.d/30-offload`<br>
`systemctl restart network`


---

### Download dotCMS (Choose one)
`cd ~`
`wget http://dotcms.com/physical_downloads/release_builds/dotcms_3.2.4.tar.gz`<br>
`wget http://dotcms.com/physical_downloads/release_builds/dotcms_3.3.2.tar.gz`<br>
`wget http://dotcms.com/physical_downloads/release_builds/dotcms_3.5.tar.gz`<br>
### or dotCMS v2
`wget http://dotcms.com/physical_downloads/release_builds/dotcms_2.5.7.tar.gz`<br>

---

## POSTGRESQL SETUP

### Initialize POSTGRESQL
`/bin/postgresql-setup initdb`

### Access psql
`sudo su - postgres
psql`

### Create dotCMS Database User
`CREATE USER dotcms WITH PASSWORD 'dotcms';`

### Create Dataase
`CREATE DATABASE "dotcms" WITH OWNER = dotcms ENCODING = 'UTF8' TABLESPACE = pg_default LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8' CONNECTION LIMIT = -1;`

### Grant Full Access to New User
`GRANT ALL ON DATABASE "dotcms" TO dotcms;`<br>
`ALTER ROLE dotcms WITH SUPERUSER;`

### Exit Psql
`\q`

### Config PostgreSQL for user authentication instead of 
`sudo nano /var/lib/pgsql/data/pg_hba.conf`
~~`host    all             all             127.0.0.1/32            ident`~~<br>
`host    all             all             127.0.0.1/32            password`

### Restart PostreSQL
`sudo systemctl restart postgresql`
---

## Install/Configure dotCMS

### Extract dotCMS archive
`mkdir -d /usr/local/dotcms`<br>
`tar -zxvf ~/dotcms_3.5.tar.gz -C /usr/local/dotcms/`

### Edit Database Config (Comment out default connector, enable PostgreSQL, and edit user params)
`nano /usr/local/dotcms/dotserver/tomcat-8.0.18/webapps/ROOT/META-INF/context.xml`<br>
Note: You may need to change tomcat-8.0.18 if the version is different

---

## Fire it up (Startup can take up to 10 minutes)
#### No need to run as root since dotCMS will still run on 8080, IPTables will handle the rest
`/usr/local/dotcms/bin/startup.sh`

### View Logs
`tail -n 100 -f /usr/local/dotcms/dotserver/tomcat-8.0.18/webapps/ROOT/dotsecure/logs/dotcms.log`

---
