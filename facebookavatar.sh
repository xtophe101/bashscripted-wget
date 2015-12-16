#!/bin/bash

userid=$1
FORMDATE=$(date +'%Y-%m-%d %H:%M:%S.%N' | sed 's/......$//g');
url=$(echo "https://graph.facebook.com/${userid}/picture")
echo "Facebook URL 1: ${url}"
url=$(curl -Ls -o /dev/null -w %{url_effective} ${url} | sed 's|c13.0.50.50/p50x50/||g')
echo "Facebook URL 2: ${url}"

filename=$(basename "${url}" | cut -d"?" -f1)
echo "Filename: ${filename}"
wget -c "${url}" --output-file "${filename}"

echo "${FORMDATE}	${userid}	${url}	${filename}" >> facebook-avatars.log


