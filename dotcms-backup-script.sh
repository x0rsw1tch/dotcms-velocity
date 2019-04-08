#!/bin/sh
## dotcms and database backup script

ACCESS_USER="user"
ACCESS_GROUP="user"
ACCESS_DIR="/home/user"

TARBALL_OUTFILE_DATE=`date +%Y%m%d`
TARBALL_OUTFILE_SUFFIX="_backup"
TARBALL_OUTFILE_EXTENSION=".tar.gz"
TARBALL_OUTFILE=${TARBALL_OUTFILE_DATE}${TARBALL_OUTFILE_SUFFIX}${TARBALL_OUTFILE_EXTENSION}

DB_USER="postgres"
DB_NAME="dotcms"
DB_OUTDIR="/tmp"
DB_OUTFILE="backup.sql"

APP_INDIR="/opt/dotcms"
APP_OUTDIR="/tmp"
APP_OUTFILE="${TARBALL_OUTFILE}"


echo ""
echo "*********************************************************"
echo "*                                                       *"
echo "*        Running Application and Database backup        *"
echo "*                                                       *"
echo "*********************************************************"
echo ""
echo '' > ${DB_OUTDIR}/${DB_OUTFILE}
chown postgres:postgres ${DB_OUTDIR}/${DB_OUTFILE}

echo ""

echo "Dumping Database \""${DB_NAME}"\" to: "\"${DB_OUTDIR}/${DB_OUTFILE}\""..."
echo ""
su - ${DB_USER} -c "pg_dump ${DB_NAME} > ${DB_OUTDIR}/${DB_OUTFILE}"

echo ""

echo "Creating Tarball of Application Directory..."
echo ${DB_OUTDIR}/${DB_OUTFILE} ' && ' ${APP_INDIR} ' > ' ${APP_OUTDIR}/${APP_OUTFILE}
echo ""
tar -czf ${APP_OUTDIR}/${APP_OUTFILE} -C ${DB_OUTDIR} ${DB_OUTFILE} -C ${APP_INDIR} .

echo ""

echo "Moving Tarball to backup location: "${ACCESS_DIR}
echo ""
mv ${APP_OUTDIR}/${APP_OUTFILE} ${ACCESS_DIR}/${TARBALL_OUTFILE}
chown ${ACCESS_USER}:${ACCESS_GROUP} ${ACCESS_DIR}/${TARBALL_OUTFILE}
echo ""
echo "DONE!"
echo ""