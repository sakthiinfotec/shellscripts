#!/bin/sh
# Usage: sh sed-usage.sh

STATES=Arizona,California,Texas

for state in $(echo $STATES | sed "s/,/ /g"); do
  echo $state
done
