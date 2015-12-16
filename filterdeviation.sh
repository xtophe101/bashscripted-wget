#!/bin/bash

#standard deviation: 40.8042 (0.160016)


for f in *.{JPG,jpg,jpeg,JPEG,png};
	do
 
	deviation=$(identify -verbose "$f" | grep deviation | tail -n 1 | cut -d":" -f2 | grep -o "[0-9.-]*" | head -n1 | bc -l)

	echo -en "\n$f - deviation is ($deviation) - "
	
	if (( $(echo "$deviation > 23" | bc -l) )); then
		echo OK	
	else 
		echo +23	
		mv "$f" empty/
	fi

done
