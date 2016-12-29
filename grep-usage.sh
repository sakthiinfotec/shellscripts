#!/bin/sh
# Usage: sh grep-usage.sh

# To list all the files containing particular text or pattern from current path
grep 'Hello' *

# To list all the files containing particular text or pattern from the given set of files
grep 'Hello' file1 file2 file3

# Regular Expression matching
grep '^Hello' file1 file2 file3

# Regular Expression matching
grep '^Hello' file1 file2 file3

# Ignorecase(-i)
grep -i 'Hello' file1

# Ignorecase printing filename along with the matched lines(-h)
grep -ih 'Hello' file1

# Invert matched lines(-v)
grep -ihv 'Hello' file1

# To print words by matched patterns(-o), not entire line
grep -o 'Hel.*' file1

# Combine with awk, to print matched records with line number
grep -hon 'aru.*' tmp tmp.bak props | awk '{print NR,$1}'

# Combine with awk, to print matched records with line number
grep -hon 'aru.*' tmp tmp.bak props | awk '{print NR,$1}'
