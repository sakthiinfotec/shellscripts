#!/bin/sh
# This script shows usages of date command.

# Usage: sh date-usage.sh

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

# Get past 6 month of year and month value and store in an array
CUR_MONTH_START_DATE=$(date +%Y-%m-01)

# Current month's start and end timestamp in UTC(-u)
CUR_MON_START_DATE_TS=`date -u -d ${CUR_MONTH_START_DATE} +%s`
CUR_MON_END_DATE_TS=`date -u -d "${CUR_MONTH_START_DATE} +1 month -1 day" +%s`

# Obtain month & year values of last 6 months w.r.t CUR_MONTH_START_DATE value
for month in {1..6}; do
  YEAR[$month]=`date -u -d "${CUR_MONTH_START_DATE} -${month} month" +%Y`
  MONTH[$month]=`date -u -d "${CUR_MONTH_START_DATE} -${month} month" +%m`
done

# Last 6 months - Start and end time stamp in UTC
START_DATE=`date -u -d "${CUR_MONTH_START_DATE} -6 months" +'%Y-%m-01'`
END_DATE=`date -u -d "${CUR_MONTH_START_DATE} -1 day" +'%Y-%m-%d'`
START_DATE_TS=`date -u -d ${START_DATE} +%s`
END_DATE_TS=`date -u -d ${END_DATE} +%s`

