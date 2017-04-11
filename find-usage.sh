#!/bin/sh
# Find command collections

find . -type f ! -name "*.jar" -print | grep -i '.*[.]*'
find . ! -name "*.jar" -type f -exec dos2unix {} \;
find ./lib ! -name "*.jar"

find . -type f -exec dos2unix {} \;
find . -type f -print0 | xargs -0 -n 1 -P 4 dos2unix 
