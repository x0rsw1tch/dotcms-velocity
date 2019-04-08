#!/bin/sh
#####################################
# dotCMS and Database Backup Script #
#####################################
#
# 1. Creates DB Dump to a SQL file
# 2. Creates a backup of the application directory
# 3. Creates a gzipped tarball of the application/DB in one file
# 4. Moves backup file to designated location
#

# Check Free Space
DISK_REQUIRED=15000000
DISK_FREE=$(df / | awk 'NR==2 { print $4 }')

if (( ${DISK_FREE} < ${DISK_REQUIRED} )); then
echo "Not enough disk space to create backup, aborting..."
exit 1
fi

# User/Group for final output file
ACCESS_USER="user"
ACCESS_GROUP="group"
ACCESS_DIR="/home/user/backups"

# Tarball file parameters
TARBALL_OUTFILE_DATE=`date +%Y%m%d`
TARBALL_OUTFILE_SUFFIX="_backup"
TARBALL_OUTFILE_EXTENSION=".tar.gz"
TARBALL_OUTFILE=${TARBALL_OUTFILE_DATE}${TARBALL_OUTFILE_SUFFIX}${TARBALL_OUTFILE_EXTENSION}

# Database Access
DB_FILEOWNER="postgres"
DB_FILEGROUP="postgres"
DB_USER="postgres"
DB_NAME="dotcms"
DB_OUTDIR="/tmp"
DB_OUTFILE="backup.sql"

# Application Backup Parameters
APP_INDIR="/usr/local/dotcms"
APP_OUTDIR="/tmp"
APP_OUTFILE="${TARBALL_OUTFILE}"
APP_EXCLUSIONS=""
#APP_EXCLUSIONS="${APP_EXCLUSIONS} --exclude=${APP_INDIR}/dotserver/tomcat-8.0.18/webapps/ROOT/assets/tmp_*"
#APP_EXCLUSIONS="${APP_EXCLUSIONS} --exclude=${APP_INDIR}/dotserver/tomcat-8.0.18/webapps/ROOT/dotsecure/esdata"
#APP_EXCLUSIONS="${APP_EXCLUSIONS} --exclude=${APP_INDIR}/dotserver/tomcat-8.0.18/logs"

# Upload
UPLOAD_ENABLE=false
UPLOAD_HOST="example.com"
UPLOAD_PORT=22
UPLOAD_USER="lightspeed"
UPLOAD_PRIVKEY="/home/user/.ssh/my_private_key"
UPLOAD_OUTDIR="/home/user"
UPLOAD_OUTFILE="${TARBALL_OUTFILE}"

# Do the things
echo ""
echo "*********************************************************"
echo "*                                                       *"
echo "*        Running Application and Database backup        *"
echo "*                                                       *"
echo "*********************************************************"
echo ""
echo '' > ${DB_OUTDIR}/${DB_OUTFILE}
chown ${DB_FILEOWNER}:${DB_FILEGROUP} ${DB_OUTDIR}/${DB_OUTFILE}

echo ""

echo "Dumping Database \""${DB_NAME}"\" to: "\"${DB_OUTDIR}/${DB_OUTFILE}\""..."
echo ""
su - ${DB_USER} -c "pg_dump ${DB_NAME} > ${DB_OUTDIR}/${DB_OUTFILE}"

echo ""

echo "Creating Tarball of Application Directory..."
echo ${DB_OUTDIR}/${DB_OUTFILE} ' && ' ${APP_INDIR} ' > ' ${APP_OUTDIR}/${APP_OUTFILE}
echo ""
tar ${APP_EXCLUSIONS} -czf ${APP_OUTDIR}/${APP_OUTFILE} -C ${DB_OUTDIR} ${DB_OUTFILE} -C ${APP_INDIR} .

echo ""
rm -f ${DB_OUTDIR}/${DB_OUTFILE}

echo "Moving Tarball to backup location: "${ACCESS_DIR}
echo ""
mv ${APP_OUTDIR}/${APP_OUTFILE} ${ACCESS_DIR}/${TARBALL_OUTFILE}
chown ${ACCESS_USER}:${ACCESS_GROUP} ${ACCESS_DIR}/${TARBALL_OUTFILE}
echo ""
echo "DONE!"
echo ""

if [[ $UPLOAD_ENABLE = true ]] ; then
scp -i ${UPLOAD_PRIVKEY} -P ${UPLOAD_PORT} ${ACCESS_DIR}/${TARBALL_OUTFILE} ${UPLOAD_USER}@${UPLOAD_HOST}:${UPLOAD_OUTDIR}/${UPLOAD_OUTFILE}
fi