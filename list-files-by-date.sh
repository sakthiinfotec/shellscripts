#!/bin/sh
# This script used to list files modified on a particular date given a path.
# Also filters based on a file name containing specific word.

# Usage: sh list-files-by-date.sh /home/sakthi/ 2016-12-01 _full_

BASE_PATH=$1
DATE=$2
CONTAINS=$3

NEXT_DATE=$(date -d "$DATE +1 day" +%Y-%m-%d)
find "$BASE_PATH" -type f -newermt $DATE ! -newermt $NEXT_DATE -print | grep "$CONTAINS"
