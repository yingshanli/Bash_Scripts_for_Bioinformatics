#!/bin/sh


# Extract fields 2, 4, and 5 from file.txt:

awk '{print $2,$4,$5}' input.txt
# Print each line where the 5th field is equal to ‘abc123’:

awk '$5 == "abc123"' file.txt
# Print each line where the 5th field is not equal to ‘abc123’:

awk '$5 != "abc123"' file.txt
# Print each line whose 7th field matches the regular expression:

awk '$7  ~ /^[a-f]/' file.txt
# Print each line whose 7th field does not match the regular expression:

awk '$7 !~ /^[a-f]/' file.txt
# Get unique entries in file.txt based on column 2 (takes only the first instance):

awk '!arr[$2]++' file.txt
# Print rows where column 3 is larger than column 5 in file.txt:

awk '$3>$5' file.txt
# Sum column 1 of file.txt:

awk '{sum+=$1} END {print sum}' file.txt
# Compute the mean of column 2:

awk '{x+=$2}END{print x/NR}' file.txt
# Replace all occurances of foo with bar in file.txt:

sed 's/foo/bar/g' file.txt
# Trim leading whitespaces and tabulations in file.txt:

sed 's/^[ \t]*//' file.txt
# Trim trailing whitespaces and tabulations in file.txt:

sed 's/[ \t]*$//' file.txt
# Trim leading and trailing whitespaces and tabulations in file.txt:

sed 's/^[ \t]*//;s/[ \t]*$//' file.txt
# Delete blank lines in file.txt:

sed '/^$/d' file.txt
# Delete everything after and including a line containing EndOfUsefulData:

sed -n '/EndOfUsefulData/,$!p' file.txt
# Remove duplicates while preserving order

awk '!visited[$0]++' file.txt