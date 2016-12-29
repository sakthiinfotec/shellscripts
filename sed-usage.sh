#!/bin/sh
# Usage: sh sed-usage.sh

# 1. Print comma(,) separated list of item one-by-one in a new line
STATES=Arizona,California,Texas

for state in $(echo $STATES | sed "s/,/ /g"); do
  echo $state
done
