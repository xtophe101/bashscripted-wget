#!/bin/bash

#quickly recover a deleted file from NTFS partition entering (part of) a filename

#usage: sudo undelete_file.sh /dev/sda1 encfs6.xml
#result: - list of found files
#        - found files recovered


#http://rationallyparanoid.com/articles/sleuth-kit.html


#eg /dev/sda1
device=$1

#eg encfs6.xml
filefind=$2

flslogfile="${filefind}.flslog"
logpath="/tmp/recovery"

mkdir -p ${logpath}
cd ${logpath}

#echo "fls -rd ${device} | grep -i \"${filefind}\""
fls -rd ${device} | grep -i "${filefind}" > ${logpath}/${flslogfile}
echo cat ${logpath}/${flslogfile}
cat ${logpath}/${flslogfile}

nodes=$(cat ${logpath}/${flslogfile} | grep -o -e "[0-9]\{1,\}-[0-9]\{1,\}-[0-9]\{1,\}" | cut -d"-" -f1 | sort | uniq)

#echo ${nodes}



for n in ${nodes}
do
	echo "-  ${n} - "
	sudo icat -r ${device} ${n} > "${n}_${filefind}"
done;

ls -lhA
file * | tee -a ${logpath}/${flslogfile}




