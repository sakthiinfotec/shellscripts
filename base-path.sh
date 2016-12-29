#!/bin/sh
# Usage: sh base-path.sh

# To print file name
filename=`basename $0`
echo $filename

# To print directory name of a given file path
dir=$(dirname "/home/sakthi/wordcount/wordcount.py")
echo "Dir: $dir"

# To print directory name of a current script
filename=`dirname $0`
cd $filename
echo "PWD: $(pwd)"
