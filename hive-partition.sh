#!/usr/bin/sh

# This shell script used to added the partitions to the hive table dynamically.
# It takes <feed-id> and <datetime> as input parameters.
# Example usage:
#   sh hive-partition.sh FEED.TYPE.FREQ "2016-10-16 14:00:00"

function show_usage() {
    echo ""
    CMD="$0"
    echo "Usage: $CMD <feed-id(FEED.TYPE.FREQ)> \"<datetime(YYYY-mm-DD HH:MM:SS)>\""
    echo "Eg.: $CMD TWTR.IO2016.H \"`date \"+%Y-%m-%d %H:00:00\"`\""
    echo ""
    exit 1;
}

# Input validation
if [ "$#" -ne 2 ]; then
  echo "ERROR: Missing arguments"
  show_usage
fi

FEED_ID="$1"
DATETIME="$2"
echo "Input feed-id:${FEED_ID}, datetime:${DATETIME}"
echo ""

# Load configurations
CONFIG_FILE="./config"
source $CONFIG_FILE

freq=`echo "$FEED_ID" | cut -d'.' -f3`

value="${feed_props_map[$FEED_ID]}"
IFS=":" read FEED_PATH TABLE_NAME <<< "$value"

# Extract Year, Month, Day and Hour for partitions
YEAR=$(date '+%Y' -d "$DATETIME")
MONTH=$(date '+%m' -d "$DATETIME")
DAY=$(date '+%d' -d "$DATETIME")
HOUR=$(date '+%H' -d "$DATETIME")

echo "Adding partition to table ${TABLE_NAME} ..."
case "$freq" in
   "M") 
     PARTITION="(year=${YEAR}, month=${MONTH})"
     LOCATION="${FEED_PATH}/${YEAR}/${MONTH}/"
     ;;
   "D")
     PARTITION="(year=${YEAR}, month=${MONTH}, day=${DAY})"
     LOCATION="${FEED_PATH}/${YEAR}/${MONTH}/${DAY}/"
     ;;
   "H") 
     PARTITION="(year=${YEAR}, month=${MONTH}, day=${DAY}, hr=${HOUR})"
     LOCATION="${FEED_PATH}/${YEAR}/${MONTH}/${DAY}/${HOUR}/"
     ;;
   *) 
     echo "ERROR: Invalid feed frequency \'$freq\'"
     show_usage
     ;;
esac

PARTITION_QUERY="ALTER TABLE ${TABLE_NAME} ADD PARTITION ${PARTITION} LOCATION '${LOCATION}';"
echo "USE ${DATABASE}; ${PARTITION_QUERY}"
echo ""
echo hive -e "USE ${DATABASE}; ${PARTITION_QUERY}"
