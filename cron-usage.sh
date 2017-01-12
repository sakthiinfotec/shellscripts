#!/bin/sh
# Commands used to schedule a batch job, backup files and transfer files in a minutes, hourly, daily, 
# monthly and weekly intervals.
# Usage: sh cron-usage.sh

# As per wiki(https://en.wikipedia.org/wiki/Cron), cron schedule pattern
# ┌───────────── minute (0 - 59)
# │ ┌───────────── hour (0 - 23)
# │ │ ┌───────────── day of month (1 - 31)
# │ │ │ ┌───────────── month (1 - 12)
# │ │ │ │ ┌───────────── day of week (0 - 6) (Sunday to Saturday; 7 is also Sunday)
# │ │ │ │ │                                       
# │ │ │ │ │
# │ │ │ │ │
# * * * * *  command to execute

# Add/edit the job schedule
crontab -e

# List the existing scheduled jobs
crontab -l

# $ crontab -l
# 30 03 10 1,4,7,10 * /opt/analytics/jobs/run-quarterly.sh
# The above job will run every quarter(Jan, Apr, Jul, Oct), 10th date, 3:30 AM hours.
