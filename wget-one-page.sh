#!/bin/bash

USERAGENT="Mozilla/5.0 (Windows NT 5.2; rv:2.0.1) Gecko/20100101 Firefox/4.0.1"
#USERAGENT="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.111 Safari/537.36"


DATETIME=$(date +'%Y-%m-%d_%H%M%S');
domain=$(echo $1 | awk -F/ '{print $3}')
wgetlogfile="./_WGET-${DATETIME}_${domain}.log";

curl -ID _HTTP_HEADER_${DATETIME}_${domain}.log ${domain}


echo "Domein: $domain";


function ask_yes_or_no() {
    read -p "$1 ([y]es or [N]o): "
    case $(echo $REPLY | tr '[A-Z]' '[a-z]') in
        y|yes) echo "yes" ;;
        *)     echo "no" ;;
    esac
}

#if [[ "no" == $(ask_yes_or_no "Proxy gebruiken ?") || \
#     "no" == $(ask_yes_or_no "Are you *really* sure?") ]]

proxy="off";
if [[ "yes" == $(ask_yes_or_no "Proxy gebruiken ?") ]]
then
	proxy="on";
	echo "Proxy gebruiken!"
fi



if [[ "yes" == $(ask_yes_or_no "Stay inside domian ?") ]]
then
	domains="-D${domain}"
fi


echo Verder

command="
wget    \"$1\" \
	-l 1 \
	--adjust-extension \
	--span-hosts \
	--convert-links \
	--backup-converted \
	--page-requisites \
	--no-check-certificate \
	--keep-session-cookies \
	--save-cookies=cookies \
	--load-cookies=cookies \
	-U \"${USERAGENT}\" \
	--html-extension \
	--tries=10 \
	--append-output \"${wgetlogfile}\" \
	--adjust-extension \
	--convert-links \
	--backup-converted \
	--proxy=${proxy} \
	 $domains
	 "
echo ${command}
echo ${command} >> _WGET_COMMAND.log


wget    "$1" \
	-l 1 \
	--adjust-extension \
	--span-hosts \
	--convert-links \
	--backup-converted \
	--page-requisites \
	--no-check-certificate \
	--keep-session-cookies \
	--save-cookies=cookies \
	--load-cookies=cookies \
	-U \"${USERAGENT}\" \
	--html-extension \
	--tries=10 \
	--append-output \"${wgetlogfile}\" \
	--adjust-extension \
	--convert-links \
	--backup-converted \
	--proxy=${proxy} \
	 $domains
