#!/bin/bash

domainlistfile=$1
for n in $(echo ${domainlistfile});
	do
	echo "============================================================================================";
	echo ${n}; whois -H ${n}  | sed -e '/Copyright/,$d' | sed  -e '/The data in/,$d' | sed  -e '/This listing/,$d'
	sleep 2;
done
