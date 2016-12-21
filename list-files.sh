#!/bin/sh
# Usage: sh list-files.sh

BASE_DIR=/home/sakthi/feeds

for file in ${BASE_DIR}/*
do
  if [[ -d "$file" ]]; then
    echo "Directory:$file"
  elif [[ -f "$file" ]]; then
    echo "File:$file"
  else
    echo "Unable to find type! :-)"
  fi
done

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
