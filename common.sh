#!/bin/sh
# Commonly used commands
# Usage: sh common.sh

# Find disk usage
du -h --summarize * | sort -h

scp /source/file/path user@target-host:/path

# use -r if folder
scp -r /source/folder/path user@target-host:/path

# To list down the processes which are using files right now. -r1 indicates refresh
lsof -r1 /tmp/sort9nkNt9
lsof -r1 /some/dir/*

# This will show processes accessing /some/dir and refresh every 2 seconds.
lsof +r2 | grep '/tmp/sort' 

# We can use ls and grep to find out the files used by chrome
ls -l /proc/*/fd | grep "chrome"

# list only files
ls -al | egrep -v "^d.*"

# join multi row of lines into a single line separate by delimitter(,)
ls | tr '\n' ','

# Prepend a line/header to an existing file
echo "id,name,salary"|cat - employee > /tmp/employee-with-header

# List a sorted uniq column values
cat /tmp/tmp-file | awk -F: '{print $2}' | sort | uniq

# Base64 Encode
echo "Hello World" | base64
# O/P: SGVsbG8gV29ybGQK

# Base64 Decode
echo "SGVsbG8gV29ybGQK" | base64 --decode
# O/P: Hello World

# Access System Environment variables
env

# Grep a particular environment variable
env | grep JAVA_HOME

# Commands to find Linux distribution name
cat /etc/*-release
cat /proc/version
lsb_release -a
uname -r

# Find out Linux kernal version
uname -a

# To get group and did details of a Linux user
id <userid/username>
# Eg.
id hadoop
id nginx

# List user groups
groups <username>
groups hadoop

# User and Group commands
sudo groupadd docker
sudo usermod -aG docker ubuntu

# Change user's home dirctory, shell and UIDs
usermod -d </new/home/path> userid
usermod -d /share/users/sakthi sakthi

usermod -s <default shell> username
usermod -s /bin/bash username

usermod -u <UserID> username
usermod -u 1211 username

# Set password
passwd <username>
passwd sakthi

# Initiate, redirection of output and error logs into a log file at one place(preferable at the begining)
ERROR_LOG_FILE="error-`date '+%Y-%m-%d_%H%M%S'`.log"
exec > $ERROR_LOG_FILE 2>&1

# String interpolation with template file using "eval" & "envsubst"
CURR_DT=$(date '+%Y-%m-%d')
START_DATE=$(date -d $CURR_DT' -1month' +%Y-%m-%d)
END_DATE="$CURR_DT"
eval "cat <<< \"$(<scripts.template.sql)\"" > scripts.sql  2> /dev/null

# String interpolcation with template file using "envsubst"
export START_DATE="$CURR_DT"
export END_DATE="$CURR_DT"
envsubst < scripts.template.sql > scripts.sql

# Include or execute another script file using dot(. ./) or source command
. ./config
# or
source ./config
# Print $USER_NAME from ./config file
echo "$USER_NAME"

# sleep & wait - Example
{ sleep 10; echo "Waking up after 10 seconds"; } &
{ sleep 4; echo "Waking up after 4 seconds"; } &
wait
echo "All jobs are done!"

# shell 'magic' variables
$$ # same 'bash' shell process id or $BASHPID
$! # Last background process id
$? # Last process exit status
$# # Input count
$@ # Input as single array
$0 # The script name itself
$<n> # Read positional input Eg. $1

# Find size of a file
stat --printf="%s" products.csv
ls -l products.csv | awk '{print $6}'

# Get Application Home/Install path
APP_HOME=$( cd "$(dirname "$0")/.." && pwd )

# Create logs dir under APP_HOME
LOG_PATH=$APP_HOME/logs
mkdir -p $LOG_PATH/logs

# Delete log files older than N days(here 15 days)
find $LOG_PATH -mtime +15 -type f -delete

# SFTP download of files
lftp sftp://ftpuser:password123@ftp.example.com -e "cd latest; lcd downloads; get products.csv; bye" >/dev/null 2>&1
lftp sftp://ftpuser:password123@ftp.example.com -e "cd latest; lcd downloads; mget abc_*.zip; bye" >/dev/null 2>&1

# File System conditions
[ -f "$PID_FILE" ] && echo "Process ID $(cat $PID_FILE)" || echo "PID file doesn't exists"
[ ! -z "$PID_FILE" ] && echo "Process ID $(cat $PID_FILE)" || echo "PID file is empty"

# Until with Retry using sleep
file=myapp.log
interval=10
until (ls $file >/dev/null 2>&1); do
    echo 'Log file $file not ready yet. Will try again in $interval seconds.';
    sleep $interval;
done;
echo 'File $file ready!';  

# Log util function
function log() {
  local msg=$1
  local datetime=$(date '+%Y-%m-%d %k:%M:%S')
  echo "$datetime $msg"
}
log "File $file download completed"  

# Sending mail with attachment via mail - command
echo "Hi Team - Batch ${JOBID} Job completed"| mail -s "Batch Job ${JOBID} - Success" ${MAIL_TO_LIST}
echo "Hi Team - Batch ${JOBID} Job Failed. PFA log file for more details!"| mail -a ${LOG_FILE} -s "Batch Job ${JOBID} - Failed!" ${MAIL_TO_LIST}

# Using Slice Operator
ymd=$(date +%Y%m%d)

echo ${ymd:0:4}
echo ${ymd:4:2}
echo ${ymd:6:2}

# Shell ereor handling
# --------------------
set -ex # Exit when Non-zero returns after executing a command / x - debug
set -o errexit # Readable version of set -e; To disable temporarily: set +e
set -o nounset # set -u, to detect unset variables in the shellscript

# Ref: https://stackoverflow.com/questions/13468481/when-to-use-set-e
set -o pipefail # pipefail makes things like misspeled-command | sed -e 's/^WARNING: //' raise errors

# Also use with bash command
bash -x command.sh

# trap - usage
error_exit() {
    JOB="$0"              # job name
    LASTLINE="$1"         # line of error occurrence
    LASTERR="$2"          # error code
    echo "ERROR in ${JOB} : line ${LASTLINE} with exit code ${LASTERR}"
    exit 1
}
trap 'error_exit ${LINENO} ${?}' ERR

ls -la un-known-file.sh

# Important usage of trap
# Ref http://www.davidpashley.com/articles/writing-robust-shell-scripts/
if [ ! -e $lockfile ]; then
   trap "rm -f $lockfile; exit" INT TERM EXIT
   touch $lockfile
   critical-section
   rm $lockfile
   trap - INT TERM EXIT
else
   echo "critical-section is already running"
fi

# Redirect output and error into separate files
command 1>stdout.log 2>stderr.log

# stdout is the default file descriptor, can just ignore
command >stdout.log 2>stderr.log

# Run command at remote server and get back results(Password less SSH must have been enabled for this!)
latest_file_date_from_remote=$(ssh user@135.60.225.110 "ls /bigdata/clicks | grep -oEi '[0-9]+_[0-9]+' | cut -d '_' -f2 | sort -r | sed -n '1p'")
latest2nd_file_date_from_remote=$(ssh user@135.60.225.110 "ls /bigdata/clicks | grep -oEi '[0-9]+_[0-9]+' | cut -d '_' -f2 | sort -r | sed -n '2p'")

# Generate range of dates from given Start and end dates
# Ref: https://stackoverflow.com/questions/28226229/bash-looping-through-dates
d=2016-08-01
while [ "$d" != 2017-04-15 ]; do 
  echo $d
  d=$(date -I -d "$d + 1 day")
  # d=$(date -d "$d + 1 day" +%Y%m%d)
done

# Drop Hive tables those containing similar name
hive -e "show tables 'temp_*'" | xargs -I '{}' hive -e 'drop table {}'

# zcat, cut and uniqe
zcat result.csv.zip | cut -d, -f4 | uniq | wc -l
