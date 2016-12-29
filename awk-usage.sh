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
