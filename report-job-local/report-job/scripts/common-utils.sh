#!/bin/bash
#
# Contains common variables, utilities, log & error functions

declare -r APP_HOME=$( cd "$(dirname "$0")/.." && pwd )
BIN_PATH=$APP_HOME/bin
CONF_PATH=$APP_HOME/conf
SCRIPTS_PATH=$APP_HOME/scripts
SAS_PATH=$APP_HOME/sas

# Load config, which contains DATABASE, QUEUE_NAME, PATHs, etc,.
CONFIG_FILE=$CONF_PATH/config
source $CONFIG_FILE

LAST_SUCCESS_RUN_DATETIME_FILE=$CONF_PATH/last-success-run-datetime
if [ -f "$LAST_SUCCESS_RUN_DATETIME_FILE" ]; then
  LAST_SUCCESS_RUN_DATETIME=$(cat $LAST_SUCCESS_RUN_DATETIME_FILE)
fi

DB_CONFIG_FILE=$CONF_PATH/.db-config
if [ -e $DB_CONFIG_FILE ]; then
  source $DB_CONFIG_FILE
else
  echo "Unable to load db DB credentials as file '$DB_CONFIG_FILE' not found. Exiting batch job with error!"
  exit 1
fi

# Job's output and erro log path
LOG_PATH=$APP_HOME/logs
mkdir -p ${LOG_PATH}

# Directory path initialization
INPUT_DATA_PATH=$APP_HOME/data/input
OUTPUT_DATA_PATH=$APP_HOME/data/output
mkdir -p $INPUT_DATA_PATH
mkdir -p $OUTPUT_DATA_PATH

EMP_RESULT=$OUTPUT_DATA_PATH/emp_result
EMP_RESULT_DEPT=$OUTPUT_DATA_PATH/emp_result_pcn
mkdir -p $EMP_RESULT
mkdir -p $EMP_RESULT_DEPT

# Create tmp dir. if not exists
TMP_PATH=$APP_HOME/tmp
mkdir -p $TMP_PATH

# Update last success run
function udpate_last_success_run() {
  echo `date "+%Y-%m-%d %T %Z"` > $LAST_SUCCESS_RUN_DATETIME_FILE
}  

# echo's log messages with current date and time
function log() {
  local datetime=$(date '+%Y-%m-%d %H:%M:%S')
  local msg="$@"
  echo "$datetime $msg"
}

# Call this function to write to stderr
log_err() {
  local datetime=$(date '+%Y-%m-%d %H:%M:%S')
  local msg="$@"
  echo "$datetime $msg" >&2
}

# Render template file with shell / environment variables
function render_template() {
  local template_file="$1"
  local rendered_file="$2"
  eval "cat <<< \"$(<${template_file})\"" > ${rendered_file} # 2> /dev/null
}
