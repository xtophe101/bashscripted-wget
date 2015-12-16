#!/bin/bash

FILE=$1

##for url in $(cat ${FILE} | grep -o '<a .*href=.*>' | sed -e 's/<a /\n<a /g' | sed -e 's/<a .*href=['"'"'"]//' -e 's/["'"'"'].*$//' -e '/^$/ d' | grep ^http | grep -v course= | grep pluginfile | grep -v player.html | sort | uniq); do echo -n "<li><a href=\"${url}\" target=\"_blank\">${url}</a></li>" >> downloads.html; done
#cat ${FILE} | grep -io '<a .*href=.*>' | sed -e 's/<a /\n<a /g' | sed -e 's/<a .*href=['"'"'"]//' -e 's/["'"'"'].*$//' -e '/^$/ d'
#cat ${FILE} | grep -io '<img .*src=.*>' | sed -e 's/<img /\n<img /g' | sed -e 's/<img .*src=['"'"'"]//' -e 's/["'"'"'].*$//' -e '/^$/ d'

cat "${FILE}" |   grep -io '[href\|src]=['"'"'"][^"'"'"']*['"'"'"]' | sed -e 's/^[href\|src]=["'"'"']//I' -e 's/["'"'"']$//I' | grep ^http
