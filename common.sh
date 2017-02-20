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
