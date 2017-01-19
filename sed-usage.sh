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

# Ref: http://www.theunixschool.com/2012/12/sed-10-examples-to-print-lines-from-file.html
cat file
AIX
Solaris
Unix
Linux
HPUX

# Print only the first line of the file:
sed -n '1p' file
AIX

# Print only the 3rd line of the file:
sed -n '3p' file
Unix

# Print only the last line of the file. Below $ indicates the last line.
sed -n '$p' file
HPUX

# Print from 3rd line till last line.
sed -n '3,$p' file
Unix
Linux
HPUX

# Print lines which does not contain 'X': Below !p indicates the negative condition to print.
sed -n '/X/!p' file
Solaris
Unix
Linux

# Print lines which contain the character 'u' or 'x' :
sed -n '/[ux]/p' file
Unix
Linux

# Print lines which end with 'x' or 'X' :
sed -n '/[xX]$/p' file
AIX
Unix
Linux
HPUX

# Print lines beginning with either 'A' or 'L':
sed -n '/^A\|^L/p' file
AIX
Linux

# Print every alternate line:
# n command prints the current line, and immediately reads the next line into pattern space. 
# d command deletes the line present in pattern space. In this way, alternate lines get printed.
sed  'n;d' file
AIX
Unix
HPUX

# Print every 2 lines:
# n;n; => This command prints 2 lines and the 3rd line is present in the pattern space. 
# N command reads the next line and joins with the current line, and d deltes the entire stuff present in the pattern space.
# With this, the 3rd and 4th lines present in the pattern space got deleted. 
# Since this repeats till the end of the file, it ends up in printing every 2 lines.
sed  'n;n;N;d' file
AIX
Solaris
HPUX

# Print lines ending with 'X' within a range of lines:
sed -n '/Unix/,${/X$/p;}' file
HPUX

# Print range of lines excluding the starting and ending line of the range:
sed -n '/Solaris/,/HPUX/{//!p;}' file
Unix
Linux

# DELETE Operations
# -----------------
# Delete if line is not a 4th line or delete all except 4th line
sed '4!d' file
Linux

# Alternatively print only 4th line
sed -n 4p file
Linux

# EXTRACT RANGE OF LINES
# ----------------------
# To extract range of lines
sed -n 2,4p file
sed '2,4!d' file
Solaris
Unix
Linux

# Extract range of lines not in a specific sequence
sed -n -e 1,2p -e 4p file
AIX
Solaris
Linux

# Edit/delete line in place
sed --in-place '/word-or-regex-pattern-to-delete-goes-here/d' file
