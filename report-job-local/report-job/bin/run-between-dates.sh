#!/bin/bash
#
# Main script to run report between a range of dates
#
# Usage: sh run-between-dates.sh [<start-date(yyyymmdd)>] [<end-date(yyyymmdd)>]
set -eu

if [ "$#" -eq 2 ]; then
  START_DATE=$1
  END_DATE=$2
elif [ "$#" -eq 1 ]; then
  START_DATE=$1
  END_DATE=$(date +%Y%m%d)
else
  START_DATE=$(date +%Y%m%d)
  END_DATE=$START_DATE
fi

APP_HOME=$( cd "$(dirname "$0")/.." && pwd )

curr_date=$START_DATE
while [ "$curr_date" -le "$END_DATE" ]; do
  COMMAND="sh $APP_HOME/bin/start-job-and-notify.sh $curr_date"
  echo "Running $COMMAND ..."
  $COMMAND
  curr_date=$(date -d "$curr_date +1 day" +%Y%m%d)
done
