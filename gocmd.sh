#!/bin/bash

clear
echo ""
echo ".=========================================================."
echo "|                                                         |"
echo "|  COMMAND LINE GOOGLE SEARCH                             |"
echo "|  ---------------------------------------------------    |"
echo "|                                                         |"
echo "|  Version: 1.0                                           |"
echo "|  Developed by: Rishi Narang                             |"
echo "|  Blog: www.wtfuzz.com                                   |"
echo "|                                                         |"
echo "|  Usage: ./gocmd.sh <search strings>                     |"
echo "|  Example: ./gocmd.sh example and test                   |"
echo "|                                                         |"
echo ".=========================================================."
echo ""

if [ -z $1 ]
then
 echo "ERROR: No search string supplied."
 echo "USAGE: ./gocmd.sh <search srting>"
 echo ""
 echo -n "Anyways for now, supply the search string here: "
 read SEARCH
else
 SEARCH=$@
fi

URL="http://google.com/search?hl=en&safe=off&q="
STRING=`echo $SEARCH | sed 's/ /%20/g'`
URI="$URL%22$STRING%22"

lynx -dump $URI > gone.tmp
sed 's/http/\^http/g' gone.tmp | tr -s "^" "\n" | grep http| sed 's/\ .*//g' > gtwo.tmp
rm gone.tmp
sed '/google.com/d' gtwo.tmp > urls
rm gtwo.tmp

echo "SUCCESS: Extracted `wc -l urls` and listed them in '`pwd`/urls' file for reference."
echo ""
cat urls
echo ""

#EOF
