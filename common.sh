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

# String interpolcation with template file using "eval" & "envsubst"
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
