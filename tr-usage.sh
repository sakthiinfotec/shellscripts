#!/bin/sh
# Usage of translate(tr) command
# Usage: sh tr-usage.sh

word="Hello World!"
res=$(echo "$word" | tr '[:upper:]' '[:lower:]')

echo "Lower case of $word is $res"

# tr - without echo
str="Hello World!"
output=$(tr '[A-Z]' '[a-z]'<<<"${str}")
