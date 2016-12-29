#!/bin/sh
# Usage: sh awk-usage.sh

awk 'BEGIN{print "Id,Name,Salary"} {print;}' OFS=',' ./input-file > ./employee.csv
