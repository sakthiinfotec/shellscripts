#!/usr/bin/sh

# This script generates the hive table partition scripts in incremental
# between given start and end dates. If end date is not passed, then it considers
# current date as an end date.
#
# The generated hive queries will be stored in partition-qry_<YYYY-MM-DD>.hql file.
#
# Syntax:
#   sh create-partitions-incremental.sh 2016-10-10
#   sh create-partitions-incremental.sh 2016-10-10 2016-10-25

function show_usage() {
    echo ""
    CMD="$0"
    echo "Usage: sh $CMD <start-date(YYYY-MM-DD)> [<end-date(YYYY-MM-DD)>]"
    echo "Eg.  : sh $CMD `date -d "-10 days" +%Y-%m-%d` `date +%Y-%m-%d`"
    echo ""
    exit 1;
}

# Input validation
if [ "$#" -eq 0 ]; then
  echo "ERROR: Missing arguments"
  show_usage
fi

START_DATE="$1"
END_DATE="$2"

# If END_DATE is empty, set current date as end date
if [ -z "$END_DATE" ]; then
  END_DATE=`date +%Y-%m-%d`
fi

BATCH_SIZE=200
count=0
PARTITION_QUERY=""

# Load configurations
BASEDIR="$( cd "$(dirname "$0")" && pwd )"
CONFIG_FILE="$BASEDIR/config"
source $CONFIG_FILE

# Partition query output file
QUERY_FILE="partition-qry_`date '+%Y-%m-%d'`.hql"
echo "Generating partition queries ..."

# First time overwrite below statement if the file already exists!
echo "USE ${DATABASE};" > "$QUERY_FILE"

function add_partition() {
  if [[ $count -gt 0 ]]; then
    QUERY="$1"
    echo "$QUERY" >> "$QUERY_FILE"
    echo ""
    # hive -e -S $QUERY
    PARTITION_QUERY=""
    count=0
  fi
}

START_DATE_TS=$(date -d "$START_DATE" +%s)
END_DATE_TS=$(date -d "$END_DATE" +%s)

for feed_id in "${!feed_props_map[@]}"; do 

  echo "Generating queries for feed \'$feed_id\'"
  value="${feed_props_map[$feed_id]}"
  IFS=":" read FEED_PATH TABLE <<< "$value"
  freq=`echo "$feed_id" | cut -d'.' -f3`
  
  for year in "${FEED_PATH}"/*; do
      if [[ -d "$year" ]]; then
        for month in "${year}"/*; do
            if [[ -d "$month" ]]; then
              for day in "${month}"/*; do
                  if [[ -d "$day" ]]; then
                    YEAR=`basename $year`
                    MONTH=`basename $month`
                    DAY=`basename $day`
                    
                    feed_date_ts=$(date -d "$YEAR-$MONTH-$DAY" +%s)
                    if [ $feed_date_ts -ge $START_DATE_TS ] && [ $feed_date_ts -le $END_DATE_TS ]; then
                      case "$freq" in
                        "D")
                          LOCATION="${day}"
                          PARTITION="(year=${YEAR}, month=${MONTH}, day=${DAY})"
                          ;;
                        "H")
                          for hr in "${day}"/*; do
                              if [[ -d "$hr" ]]; then
                                HR=`basename $hr`
                                PARTITION="(year=${YEAR}, month=${MONTH}, day=${DAY}, hr=${HR})"
                                LOCATION="${hr}"
                              fi
                          done
                          ;;
                      esac
                      
                      QRY="ALTER TABLE ${TABLE} ADD PARTITION ${PARTITION} LOCATION '${LOCATION}';"
                      PARTITION_QUERY="$PARTITION_QUERY $QRY"
                      count=$((count+1))
                      if [[ $((count % BATCH_SIZE)) == 0 ]]; then
                        add_partition "$PARTITION_QUERY"
                      fi

                    fi  # START_DATE_TS <= feed_date_ts <= END_DATE_TS validation
                  fi  # Validate if ${day} is directory
              done
            fi
        done
      fi
  done
done

echo "Adding remaining partition queries ..."
add_partition "$PARTITION_QUERY"
echo "Partition queries stored in '$QUERY_FILE' file ..."
