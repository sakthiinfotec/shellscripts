#!/bin/sh
# Usage: sh awk-usage.sh

awk 'BEGIN{print "Id,Name,Salary"} {print;}' OFS=',' ./input-file > ./employee.csv

# Print 3rd column(i.e Salary) from employee
awk 'BEGIN{FS=","} {print $3}' ./employee.csv

# Print 3rd column(i.e Salary), calculate & print sum of salary
awk 'BEGIN{FS=","} { sum+=$3; print $3} END{ print "Total Salary:",sum}' ./employee.csv
