#!/bin/bash
#
# To extract empid and dept from emp_dept table
set -eu

start_time=$(date +%s)

RUNID=$1
dept_year=$2
dept_start_month=$3
dept_end_month=$4
quarter_name=$5

APP_HOME=$( cd "$(dirname "$0")/.." && pwd )
source $APP_HOME/scripts/common-utils.sh $0

log "Input parameters are RUNID:$RUNID, dept_year:$dept_year, dept_start_month:$dept_start_month, dept_end_month=$dept_end_month"

# Move only if *.zip files exists in the last run output path
ZIP_FILES=`find $EMPID_DEPT_MAPPING/ -name "*.zip"`
if [ ! -z $ZIP_FILES ]; then
  log "Moving last run output(*.zip) from '$EMPID_DEPT_MAPPING' into '$BACKUP_BASE_PATH'"
  mv $EMPID_DEPT_MAPPING/*.zip $BACKUP_BASE_PATH/*
fi

# Remove only if one or mote file(s) exists in the last run output path
ALL_FILES=`ls $EMPID_DEPT_MAPPING`
if [ ! -z $ALL_FILES ]; then
  log "Cleaning up last run output path '$EMPID_DEPT_MAPPING'"
  rm -f $EMPID_DEPT_MAPPING/*
fi

EMPID_DEPT_MAPPING_csv=$EMPID_DEPT_MAPPING/empid_dept_mapping_$quarter_name.csv
log "Extracting empid - dept from emp_dept table and storing in a file '$EMPID_DEPT_MAPPING_csv' ..."
hive -i $TMP_PATH/hive-init.hql --hiveconf hive.cli.print.header=true --hiveconf hive.resultset.use.unique.column.names=false \
  -e "SELECT emp_id, dept_id, dept_name;" | sed 's/\t/,/g' > $EMPID_DEPT_MAPPING_csv
log "Empid - dept mapping extraction completed!"

EMPID_DEPT_MAPPING_csv_zip=${EMPID_DEPT_MAPPING_csv}.zip
log "Compressing final output file '$EMPID_DEPT_MAPPING_csv' and store into '$EMPID_DEPT_MAPPING_csv_zip'"
zip -j $EMPID_DEPT_MAPPING_csv_zip $EMPID_DEPT_MAPPING_csv

log "Deleting older backup files"
find $BACKUP_BASE_PATH -mtime +120 -type f -delete

end_time=$(date +%s)
log "$0 : Job(${RUNID}) took $[($end_time - $start_time)/60] minutes to complete"
