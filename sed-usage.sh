#!/bin/sh
# Usage: sh sed-usage.sh

# 1. Print comma(,) separated list of items one-by-one in a new line
STATES=Arizona,California,Texas

for state in $(echo $STATES | sed "s/,/ /g"); do
  echo $state
done

# 2. Insert a line or column header at first row in a file
sed -i '1s/^/Id,Name,Salary\n/' employee-list.csv

# 3. Delete line(s) in the input file

# Delete 2nd line from the input file
sed 2d ./input-file

# To remove the line and print the output to standard out:
sed '/regex pattern to match/d' ./input-file
sed '/regex pattern to match/d' ./input-file > ./output-file

# To directly modify the file (and create a backup called, for eg. input-file.bak):
sed -i.bak '/pattern to match/d' ./input-file
