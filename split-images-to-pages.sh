#!/bin/bash

file=$1
echo $file



if [ -a "${file}" ]; then 

	filename=$(basename "$file")
	extension="${filename##*.}"
	filename="${filename%.*}"

	width=$(mediainfo "${file}"  | grep -i width | grep -oe "\([0-9 ]*\)" | xargs | sed 's| ||g');
	height=$(bc <<< "$width*135/100")
	convert "${file}" -crop ${width}x${height} +repage tile_%d_${filename}.png
	convert tile*${filename}.png ${filename}.pdf


else	echo "file doen'st exist";

fi
