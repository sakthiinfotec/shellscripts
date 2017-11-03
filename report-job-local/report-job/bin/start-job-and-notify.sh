#!/usr/bin/env bash
#
# Main script to run report generation batch job
# Code deployed in path: /usr/report-job

REPORT_RUN_DATE=$(date +%Y%m%d)
if [ "$#" -eq 1 ]; then
  # If particular date needs rerun, then report run date is received 
  # as input. Otherwise current date is taken as the report run date.
  REPORT_RUN_DATE=$1
fi

# Get application home path
APP_HOME=$( cd "$(dirname "$0")/.." && pwd )
source $APP_HOME/scripts/common-utils.sh

# Initialize run id
RUNID=`date +%Y%m%d%H%M%S`

# Logging file initialization
declare -r LOG_FILE="${LOG_PATH}/report_${RUNID}.log"
echo "Job started with runid:${RUNID}, check log file ${LOG_FILE} for further details" >&2

sh $APP_HOME/bin/run-report-monthly.sh $RUNID $LOG_FILE $REPORT_RUN_DATE
JOB_RETCODE="$?"

CURR_DATETIME=$(date +"%Y-%m-%d %T %Z")
JOB_NAME="Report"
if [ "$JOB_RETCODE" -eq 0 ]; then
  
  echo -e "Hi Team,

${JOB_NAME} job completed. Please find below report details.

Report path: ${REPORT_FILE_NAME}
Job User: $USER
Server: $HOSTNAME(`hostname -i`)
App. Home: $APP_HOME
Alert date: ${CURR_DATETIME}

Thanks" | mailx -s "${JOB_NAME} - Job Completed Successfully" ${MAIL_RECEPIENTS_WHEN_SUCCESS}

  # Update last successful run
  udpate_last_success_run
  
else
  # if job fails
  COMPRESSED_LOG_FILE=$LOG_FILE.zip
  zip -j $COMPRESSED_LOG_FILE $LOG_FILE
  
  echo -e "Hi Team,

${JOB_NAME} job failed with status code '$JOB_RETCODE'.

Job Status Code: $JOB_RETCODE
Job User: $USER
Server: $HOSTNAME(`hostname -i`)
App. Home: $APP_HOME
Alert date: ${CURR_DATETIME}
Last successful run on: ${LAST_SUCCESS_RUN_DATETIME}

For more details, please find the attached log file.

Thanks" | mailx -a $COMPRESSED_LOG_FILE -s "${JOB_NAME} - Job Failed!" ${MAIL_RECEPIENTS_WHEN_FAILURE}

  # Remove compressed log file
  rm -rf $COMPRESSED_LOG_FILE
fi
