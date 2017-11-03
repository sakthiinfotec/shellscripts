#!/bin/bash
#
# Main script to run report for last N days
#
# Usage: sh run-for-last-n-days.sh [<N>]
set -eu

last_n_days=0
if [ "$#" -eq 1 ]; then
  last_n_days=$1
fi

APP_HOME=$( cd "$(dirname "$0")/.." && pwd )

# N-days prior to current date
START_DATE=$(date -d "${last_n_days} days ago" +%Y%m%d)

# Current date
END_DATE=$(date +%Y%m%d)

curr_date=$START_DATE
while [ "$curr_date" -le "$END_DATE" ]; do
  COMMAND="sh $APP_HOME/bin/start-job-and-notify.sh $curr_date"
  echo "Running $COMMAND ..."
  $COMMAND
  curr_date=$(date -d "$curr_date +1 day" +%Y%m%d)
done
