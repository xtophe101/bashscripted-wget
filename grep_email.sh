#!/bin/bash

# WHAT DOES IT DO:
# GREP TEXTFILES FOR EMAILADRESSES AND SORT THEM BY TLD, AND (SUB)DOMAIN

echo "Gevonden mailadressen, gesorteerd:"
cat "$1" | grep -E -o "\b[a-zA-Z0-9.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z0-9.-]+\b" | sort | uniq -i | sed 's|@|\t@|g' | sed 's|\(.*\)\(\.[A-Za-z]\{2,3\}\)|\1\t\2|g' | sort -k3,3 -k2,2 -k1,1

echo -e "\nGevonden domeinen, gesorteerd:"
cat "$1" | grep -E -o "\b[a-zA-Z0-9.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z0-9.-]+\b" | sort | uniq -i | sed 's|@|\t@|g' | sed 's|\(.*\)\(\.[A-Za-z]\{2,3\}\)|\1\t\2|g' | sort -k2,2 | cut -f2,3 | sort | uniq | sed 's|@||g' | sed 's|\t||g'

#grep -i -o '[A-Z0-9._%+-]\+@[A-Z0-9.-]\+\.[A-Z]\{2,\}' /tmp/mailadressen.txt | sort | uniq -c
