#!/bin/bash


FILES=$(find ./ -type f -iname "*.jpg")
RPRT="barcodes.log"

rm barcodes.log


for f in $FILES
do
	BCODE=$(zbarimg "$f" -q | cut -d":" -f2)
	MD5HSH=$(md5sum "$f" | cut -d" " -f1)
	echo $f: $BCODE \($MD5HSH\)
	echo -en "$f\t$MD5HSH\t$BCODE\n" >> $RPRT
done

