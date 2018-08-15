!#/bin/bash

POSTGRESQL_VERISON_9_RPM="https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm"
POSTGRESQL_VERISON_10_RPM="https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-7-x86_64/pgdg-centos10-10-2.noarch.rpm"

POSTGRESQL_VERISON_9_PACKAGES="postgresql96 postgresql96-server"
POSTGRESQL_VERISON_10_PACKAGES="postgresql10 postgresql10-server"

PREREQUISITE_PACKAGE_LIST_STEP_ONE="epel-release"
PREREQUISITE_PACKAGE_LIST_STEP_TWO="certbot httpd mod_proxy_html mod_ssl wget curl nano htop mc iptables-services setroubleshoot setools ant java-1.8.0-openjdk java-1.8.0-openjdk-headless nmap monit"

PREREQUISITE_PACKAGES_INSTALLED=false

##
## STEP 1: Prerequisites
##


read -p "Is the OS up to date?" -n 1 -r OS_UP_TO_DATE
echo    # (optional) move to a new line
if [[ $OS_UP_TO_DATE =~ ^[Yy]$ ]]
then
    echo 'Which version of PostgreSQL do you want to use?'
    echo '1. Version 9 (default/recommended)'
    echo '2. Version 10 (experimental)'
    echo
    read -p "Version: " -r POSTGRESQL_VERSION_CHOICE

    if [[ $POSTGRESQL_VERSION_CHOICE = 1 ]]
        yum -y install ${POSTGRESQL_VERISON_9_RPM}
        yum -y install ${POSTGRESQL_VERISON_9_PACKAGES}
    fi
    if [[ $POSTGRESQL_VERSION_CHOICE = 2 ]]
        echo
        echo 'Bear in mind, at the time of writing this, dotCMS support of PostgresSQL 10 is experimental'
        echo 
        read -p "Continue (y/n)?" -n 1 -r POSTGRES10_WARNING_ACK
        if [[ $POSTGRES10_WARNING_ACK =~ ^[Yy]$ ]]
            yum -y install ${POSTGRESQL_VERISON_10_RPM}
            yum -y install ${POSTGRESQL_VERISON_10_PACKAGES}
        else
            echo
            read -p "Install Version 9 (y/n)?" -n 1 -r POSTGRES_INSTALL_NINE
            echo
            if [[ $POSTGRES_INSTALL_NINE =~ ^[Yy]$ ]]
                yum -y install ${POSTGRESQL_VERISON_9_RPM}
                yum -y install ${POSTGRESQL_VERISON_9_PACKAGES}
            fi
        fi
    fi
else
    read -p "Do you want to update the OS?" -n 1 -r UPDATE_OS_CHOICE
    if [[ $UPDATE_OS_CHOICE =~ ^[Yy]$ ]]
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