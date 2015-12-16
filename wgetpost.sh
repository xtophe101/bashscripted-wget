#!/bin/bash

#USERAGENT="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.111 Safari/537.36"

echo "****************************************************************************"
echo "**                           POST DATA                                    **"
echo "****************************************************************************"

wget    "$1" \
	--post-data "$2" \
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
	--backup-converted

