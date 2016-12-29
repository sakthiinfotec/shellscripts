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

