#!/bin/bash


for f in *.{JPG,jpg,jpeg,JPEG,png};
	do
 
	skewness=$(identify -verbose "$f" | grep skewness | tail -n 1 | cut -d":" -f2 | grep -o "[0-9.-]*" | bc -l)

	echo -en "\n$f - skewness is ($skewness) - "
	
	if (( $(echo "$skewness > 0" | bc -l) )); then
		echo OK	
	else 
		echo DARK	
		mv "$f" skew_ngtv/
	fi

done
