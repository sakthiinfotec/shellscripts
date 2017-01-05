#!/bin/sh
# Usage: sh base-path.sh

# To print file/script name(with extension if supplied)
filename=`basename $0`
echo $filename

# To print directory name of a given file path. Below command output will be /home/sakthi/wordcount.
dir=$(dirname "/home/sakthi/wordcount/wordcount.py")
echo "Dir: $dir"

# To print directory name of a current script
filename=`dirname $0`
cd $filename
echo "PWD: $(pwd)"

# or the above same command in a single line
echo "$( cd $( dirname $0 ) && pwd )"
