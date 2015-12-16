#!/bin/bash


INPUT=$1
OUTPUT=$2

if [[ ! -f $INPUT ]]; then
	echo $INPUT does not exist
	exit 1;
fi

if [[ -f $OUTPUT ]]; then
	echo $INPUT already exists! try another name
	exit 2;
fi

gs -o "${OUTPUT}" -sDEVICE=pdfwrite -dPDFFitPage -r300x300 -g2483x3510 "${INPUT}"


