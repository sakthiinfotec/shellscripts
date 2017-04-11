#!/bin/sh
# Usage: sh awk-usage.sh

# Read input file with fields delimitted by space and output with fields delimitted by comma(,); Default FS is space.
# The 'print' statement in BEGIN{} part, additionally insert column header as a first line in the output.
awk 'BEGIN{FS=" "; OFS=","; print "Id,Name,Salary"} {print $1,$2,$3;}' ./input-file > ./employee.csv

# Print 3rd column(i.e Salary) from employee
awk 'BEGIN{FS=","} {print $3}' employee.csv

# Print 3rd column(i.e Salary), calculate & print sum of salary
awk 'BEGIN{FS=","} { sum+=$3; print $3} END{ print "Total Salary:",sum}' employee.csv

# Prints file-name, record number, file specific record number, record/line
awk '{print FILENAME, NR, FNR, $0}' file1 file2 file3

# Extract full line when column 4 has 2 or more characters separated by comma
awk '$4 ~ ","' file
awk '$4 ~ /([[:alpha:]])+,[[:alpha:]]/{print}' file
awk 'length($4) > 2 && $4 ~ /^([^,],)+[^,]$/' file

# Extract full line when column 4 has 2 or more characters(A,E,I,O,U) separated by comma
awk 'length($4) > 2 && $4 ~ /([AEIOU],)+[AEIOU]/' file

# Delete a particular line in a file
awk '!/pattern/' file > temp && mv temp file

# Combine with Pipe input
ls -l | awk '!($9=="") { print $9 }'
cat /etc/group | awk -F':' '{ print $3 }'

# RegEx patterns(~ /pattern/)
cat products.csv | awk '$4 ~ /electronics/{print}'
