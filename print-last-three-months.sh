#!/bin/sh
# This script start date and end date from last 3 months duration.

# Usage: sh print-last-three-months.sh

# 3rd last month
START_YEAR=`date --date='-3 month' +'%Y'`
START_MONTH=`date --date='-3 month' +'%m'`

# To get last month's last date
END_YEAR=`date -d "$(date +%Y-%m-01) -1 day" +%Y`
END_MONTH=`date -d "$(date +%Y-%m-01) -1 day" +%m`
END_DAY=`date -d "$(date +%Y-%m-01) -1 day" +%d`

START_DATE="${START_YEAR}-${START_MONTH}-01"
END_DATE="${END_YEAR}-${END_MONTH}-${END_DAY}"
LAST_MONTH_START_DATE="${END_YEAR}-${END_MONTH}-01"

echo "${START_DATE} ${END_DATE} ${LAST_MONTH_START_DATE}"
