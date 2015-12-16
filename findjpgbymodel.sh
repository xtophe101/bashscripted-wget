#!/bin/bash

now=`date +%s`
toen=$(date +%s -d "28 day ago")

cameraModel="iPhone"

for file in *.jpg; do
	if (jhead "${file}" | grep "Camera model" | grep -qi "${cameraModel}") && [[ `stat -c %Y "${file}"` -gt "$toen" ]]; then
                changed=`stat -c %Y "$file"`
		echo "yes for $file on ${changed}"
#		jhead "${file}"
	fi

done




exit 0;
