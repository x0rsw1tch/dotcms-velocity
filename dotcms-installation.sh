!#/bin/bash

POSTGRESQL_VERISON_9_RPM="https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm"
POSTGRESQL_VERISON_10_RPM="https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-7-x86_64/pgdg-centos10-10-2.noarch.rpm"

POSTGRESQL_VERISON_9_PACKAGES="postgresql96 postgresql96-server"
POSTGRESQL_VERISON_10_PACKAGES="postgresql10 postgresql10-server"

PREREQUISITE_PACKAGE_LIST_STEP_ONE="epel-release"
PREREQUISITE_PACKAGE_LIST_STEP_TWO="httpd wget curl nano htop mc iptables-services java-1.8.0-openjdk java-1.8.0-openjdk-headless nmap lsof certbot mod_proxy_html mod_ssl setroubleshoot setools ant monit"

POSTGRESQL_VERSION_9_HBACONF_PATH="/var/lib/pgsql/9.6/data/pg_hba.conf"
POSTGRESQL_VERSION_10_HBACONF_PATH="/var/lib/pgsql/10.2/data/pg_hba.conf"


PREREQUISITE_PACKAGES_INSTALLED=false
DOTCMS_USER_CONFIGURED=false
POSTGRESQL_RUNNING=false
POSTGRESQL_DATABASE_CREATED=false
DATABASE_CONFIGURED=false
POSTGRESQL_CONFIGURED=false




##
## STEP 1: Prerequisites
##


read -p "Is the OS up to date?" -n 1 -r OS_UP_TO_DATE
echo    # (optional) move to a new line
if [[ $OS_UP_TO_DATE =~ ^[Yy]$ ]] ; then
    echo 'Which version of PostgreSQL do you want to use?'
    echo '1. Version 9 (default/recommended)'
    echo '2. Version 10 (experimental)'
    echo
    read -p "Version: " -r POSTGRESQL_VERSION_CHOICE

    if [[ $POSTGRESQL_VERSION_CHOICE = 1 ]] ; then
        yum -y install ${POSTGRESQL_VERISON_9_RPM}
        yum -y install ${POSTGRESQL_VERISON_9_PACKAGES}
    fi
    if [[ $POSTGRESQL_VERSION_CHOICE = 2 ]] ; then
        echo
        echo 'Bear in mind, at the time of writing this, dotCMS support of PostgresSQL 10 is experimental'
        echo 
        read -p "Continue (y/n)?" -n 1 -r POSTGRES10_WARNING_ACK
        if [[ $POSTGRES10_WARNING_ACK =~ ^[Yy]$ ]] ; then
            yum -y install ${POSTGRESQL_VERISON_10_RPM}
            yum -y install ${POSTGRESQL_VERISON_10_PACKAGES}
        else
            echo
            read -p "Install Version 9 (y/n)?" -n 1 -r POSTGRES_INSTALL_NINE
            echo
            if [[ $POSTGRES_INSTALL_NINE =~ ^[Yy]$ ]] ; then
                yum -y install ${POSTGRESQL_VERISON_9_RPM}
                yum -y install ${POSTGRESQL_VERISON_9_PACKAGES}
            fi
        fi
    fi
else
    read -p "Do you want to update the OS?" -n 1 -r UPDATE_OS_CHOICE
    if [[ $UPDATE_OS_CHOICE =~ ^[Yy]$ ]] ; then
        yum -y update
    else
        echo "The OS must be updated before proceeding. Exiting installation"
        exit 1
    fi
fi

echo '######################################'
echo '## Installing Prerequisite Packages ##'
echo '######################################'

if yum -y install ${PREREQUISITE_PACKAGE_LIST_STEP_ONE}; then
    if yum -y install ${PREREQUISITE_PACKAGE_LIST_STEP_TWO}; then
        PREREQUISITE_PACKAGES_INSTALLED=true
    fi
fi

if [ $PREREQUISITE_PACKAGES_INSTALLED = true ] ; then

else
    echo "Prerequisite packages failed to install... Aborting"
    exit 1
fi


##
## STEP 2: Get Info from User
##

if [ $PREREQUISITE_PACKAGES_INSTALLED = true ] ; then

	echo
	echo '##################################'
	echo '## STEP 2: Users and passwords  ##'
	echo '##################################'
	echo
	echo "Both the Linux user and Database user for dotCMS will be \"dotcms\""
	echo
	read -p "Enter dotCMS Linux User's Password:" -r DOTCMS_LINUX_USER_PASSWORD
	read -p "Enter dotCMS Database User's Password:" -r DOTCMS_DATABASE_PASSWORD

	groupadd dotcms
	useradd -M dotcms -g dotcms
	if echo "dotcms:${DOTCMS_LINUX_USER_PASSWORD}" | chpasswd; then
		DOTCMS_USER_CONFIGURED=true
	else
		echo "Error setting dotcms password, aborting..."
		exit 1
	fi

fi


##
## STEP 3: Configure Database
##

if [ $DOTCMS_USER_CONFIGURED = true ] ; then

	echo
	echo '###################################'
	echo '## STEP 3: Configure PostgresSQL ##'
	echo '###################################'
	echo

	if [[ $POSTGRESQL_VERSION_CHOICE = 1 ]] ; then
		/usr/pgsql-9.6/bin/postgresql96-setup initdb
		systemctl enable postgresql-9.6
		if systemctl start postgresql-9.6; then
			POSTGRESQL_RUNNING=true
		else
			echo "Error attempting to start PostgresSQL, aborting..."
			exit 1
		fi
	fi
	if [[ $POSTGRESQL_VERSION_CHOICE = 2 ]] ; then
		/usr/pgsql-10/bin/postgresql-10-setup initdb
		systemctl enable postgresql-10
		if systemctl start postgresql-10; then
			POSTGRESQL_RUNNING=true
		else
			echo "Error attempting to start PostgresSQL, aborting..."
			exit 1
		fi
	fi

fi

if [ $POSTGRESQL_RUNNING = true ] ; then
	echo
	echo "Creating Database..."
	echo
	
	
	sudo -u postgres psql -c "CREATE USER dotcms WITH PASSWORD \"${DOTCMS_DATABASE_PASSWORD}\";"
	sudo -u postgres psql -c "CREATE DATABASE \"dotcms\" WITH OWNER = dotcms ENCODING = 'UTF8' TABLESPACE = pg_default LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8' CONNECTION LIMIT = -1;"
	sudo -u postgres psql -c "GRANT ALL ON DATABASE \"dotcms\" TO dotcms;"
	if sudo -u postgres psql -c "ALTER ROLE dotcms WITH SUPERUSER;"; then
		POSTGRESQL_DATABASE_CREATED=true
	else
		echo "Error attempting create dotCMS database..."
		exit 1
	fi
fi


if [ $POSTGRESQL_RUNNING = true ] ; then
	echo
	echo "Configuring hba.conf..."
	echo

	POSTGRESQL_EDIT_CONF_SUCCESS=false

	if [[ $POSTGRESQL_VERSION_CHOICE = 1 ]] ; then
		
		if sed -i '/host    all             all             127.0.0.1\/32            md5/c host    all             all             127.0.0.1\/32            password' ${POSTGRESQL_VERSION_9_HBACONF_PATH}; then
			POSTGRESQL_EDIT_CONF_SUCCESS=true
		fi
		
		if sed -i '/host    all             all             127.0.0.1\/32            ident/c host    all             all             127.0.0.1\/32            password' ${POSTGRESQL_VERSION_9_HBACONF_PATH}; then
			POSTGRESQL_EDIT_CONF_SUCCESS=true
		fi
		
	fi

	if [[ $POSTGRESQL_VERSION_CHOICE = 2 ]] ; then
		if sed -i '/host    all             all             127.0.0.1\/32            md5/c host    all             all             127.0.0.1\/32            password' ${POSTGRESQL_VERSION_10_HBACONF_PATH}; then
			POSTGRESQL_EDIT_CONF_SUCCESS=true
		fi
		
		if sed -i '/host    all             all             127.0.0.1\/32            ident/c host    all             all             127.0.0.1\/32            password' ${POSTGRESQL_VERSION_10_HBACONF_PATH}; then
			POSTGRESQL_EDIT_CONF_SUCCESS=true
		fi
	fi

	if [[ $POSTGRESQL_EDIT_CONF_SUCCESS = true ]] ; then

		echo
		echo "Please verify pg_hba.conf..."
		echo
		if [[ $POSTGRESQL_VERSION_CHOICE = 1 ]] ; then
			sed -n '/host    all             all             127.0.0.1\/32            password/p' ${POSTGRESQL_VERSION_9_HBACONF_PATH}
		fi
		if [[ $POSTGRESQL_VERSION_CHOICE = 2 ]] ; then
			sed -n '/host    all             all             127.0.0.1\/32            password/p' ${POSTGRESQL_VERSION_10_HBACONF_PATH}
		fi
		echo "Should Match:"
		echo "host    all             all             127.0.0.1/32            password"
		echo

		read -p "Does it Match (y/n)?" -n 1 -r POSTGRES_EDIT_MATCH
		if [[ $POSTGRES_EDIT_MATCH =~ ^[Yy]$ ]] ; then
			POSTGRESQL_CONFIGURED=true
		else
				echo
				echo "Please edit file manually... Refer to installation guide for guidance"
				read -p "Press enter to continue"
			if [[ $POSTGRESQL_VERSION_CHOICE = 1 ]] ; then
				nano ${POSTGRESQL_VERSION_9_HBACONF_PATH}
				POSTGRESQL_CONFIGURED=true
			fi
			if [[ $POSTGRESQL_VERSION_CHOICE = 2 ]] ; then
				nano ${POSTGRESQL_VERSION_9_HBACONF_PATH}
				POSTGRESQL_CONFIGURED=true
			fi
		fi

		if [[ $POSTGRESQL_CONFIGURED = true ]] ; then
			echo
			echo "Restarting PostgresSQL..."
			echo
			systemctl restart postgresql
		fi
	fi
fi


##
## STEP 4: Setup dotCMS
##

if [ $DOTCMS_USER_CONFIGURED = true ] ; then

	echo
	echo '##########################'
	echo '## STEP 4: Setup dotCMS ##'
	echo '##########################'
	echo




fi