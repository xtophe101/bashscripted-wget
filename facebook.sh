#!/bin/bash

# FACEBOOK PROFILE CRAWLER
# VERSION 0.9
# THIS SCRIPT LOGS IN TO FACEBOOK WITH ENTERED USERNAME AND PASSWORD
# AFTER LOG IN IT CRAWLS THE FACEBOOK PAGE TO UNLIMITED PAGE LEVELS (CTRL-Z TO CANCEL)
# MORE INFORMATION ON http://open4n6.org/p/fpc/

#ENTER THE FACEBOOK USERNAME (www.facebook.com/>>>USERNAME<<<)
USR=$1

#ENTER THE LOGIN USERNAME
MAIL=""

#ENTER THE LOGIN PASSWORD
PWD=""

RECPATH="/"
LOGFILE="logfile${USR}.log"

#USERAGENT="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.111 Safari/537.36"
USERAGENT="Mozilla/5.0 (Windows NT 5.2; rv:2.0.1) Gecko/20100101 Firefox/4.0.1"

CURRDATE=$(date +'%Y-%m-%d');
CURRTIME=$(date +'%H:%M');
IP=$(wget "http://myip.xtophe.com/fpc0.9/" -q -O -); 
echo -e "Your current external IP : ${IP}" | tee -a ${RECPATH}/${LOGFILE}







echo "****************************************************************************"
echo "**                       https://www.facebook.com/${USR}	 	        **"
echo "****************************************************************************"

wget    "https://www.facebook.com/" \
	--no-check-certificate \
	--keep-session-cookies \
	--save-cookies=cookies \
	-U "${USERAGENT}" \
	-S


echo "****************************************************************************"
echo "**                            LOGIN TO FACEBOOK                           **"
echo "****************************************************************************"

wget    "https://www.facebook.com/login.php?login_attempt=1" \
	--post-data "email=${MAIL}&pass=${PWD}" \
	--no-check-certificate \
	--keep-session-cookies \
	--save-cookies=cookies \
	--load-cookies=cookies \
	-U "${USERAGENT}" \
	-S \
	--restrict-file-names=windows \
	--html-extension \
	--tries=10 \
	--append-output "./wget-logfile.log" \
	--adjust-extension \
	--convert-links \
	--backup-converted \
	--base=http://www.facebook.com/



echo "****************************************************************************"
echo "** MIRROR COMPLETE WEBSITE VAN https://www.facebook.com/${USR}            **"
echo "****************************************************************************"
wget    "https://www.facebook.com/${USR}" \
	-c \
	--no-check-certificate \
	--keep-session-cookies \
	--save-cookies=cookies \
	--load-cookies=cookies \
	-U "${USERAGENT}" \
	-S \
	--mirror \
	--restrict-file-names=windows \
	--html-extension \
	--tries=10 \
	--append-output "./wget-logfile.log" \
	--adjust-extension \
	--convert-links \
	--backup-converted \
	-Hr
	-rH -Dwww.facebook.com,facebook.com,fbstatic-a.akamaihd.net,akamaihd.net,fbcdn.net


