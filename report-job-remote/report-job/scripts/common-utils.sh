#!/bin/bash
#
# Contains common variables, utilities, log & error functions

COMMAND="$0"

declare -r APP_HOME=$( cd "$(dirname "$COMMAND")/.." && pwd )
declare -r BIN_PATH=$APP_HOME/bin
declare -r CONF_PATH=$APP_HOME/conf
declare -r SCRIPTS_PATH=$APP_HOME/scripts
declare -r HQL_PATH=$APP_HOME/hql
declare -r LOG_PATH=$APP_HOME/logs
declare -r TMP_PATH=$APP_HOME/tmp

# Create(if doesn't exist) log, tmp, backup and data dirs. each time during startup
mkdir -p $LOG_PATH
mkdir -p $TMP_PATH

declare -r DATA_INPUT_PATH=$APP_HOME/data/input
declare -r DATA_OUTPUT_PATH=$APP_HOME/data/output
mkdir -p $DATA_INPUT_PATH
mkdir -p $DATA_OUTPUT_PATH

declare -r emp_id_name_MAPPING=$DATA_OUTPUT_PATH/emp_id_name_mapping
mkdir -p $EMP_ID_NAME_MAPPING

BACKUP_BASE_PATH=$APP_HOME/backup
mkdir -p $BACKUP_BASE_PATH
declare -r BACKUP_BASE_PATH=$( cd "$BACKUP_BASE_PATH" && pwd )

# Load config, which contains DATABASE, QUEUE_NAME, etc,.
CONFIG_FILE=$CONF_PATH/config
source $CONFIG_FILE

LAST_SUCCESS_RUN_DATETIME_FILE=$CONF_PATH/last-success-run-datetime
if [ -f "$LAST_SUCCESS_RUN_DATETIME_FILE" ]; then
  LAST_SUCCESS_RUN_DATETIME=$(cat $LAST_SUCCESS_RUN_DATETIME_FILE)
fi

# Logging file initialization
declare -r LOG_FILE="${LOG_PATH}/remote_report_${RUNID}.log"

# Update last success run
function udpate_last_success_run() {
  echo `date "+%Y-%m-%d %T %Z"` > $LAST_SUCCESS_RUN_DATETIME_FILE
}  

# echo's log messages with current date and time
log() {
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

# Transform hive-init file
render_template $CONF_PATH/hive-init.template $TMP_PATH/hive-init.hql
