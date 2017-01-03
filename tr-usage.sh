#!/bin/sh
# Usage of translate(tr) command
# Usage: sh tr-usage.sh

word="Hello World!"
res=$(echo "$word" | tr '[:upper:]' '[:lower:]')

echo "Lower case of $word is $res"
