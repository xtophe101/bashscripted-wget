#!/bin/bash
#Content-Type: message/rfc822
#Content-Type: application/pdf;
#Content-Disposition: attachment;

INFILE=$1
echo Working on "${INFILE}"
#INFILE="test.eml"
#INFILE="jaja.txt"
OCCURENCE=jaja
MESSAGES=$(cat ${INFILE} | egrep "Content-Type: message/rfc822" | wc -l)
FROM='"Content-Type: message/rfc822"'
TO='Content-Type: message\/rfc822; name="ForwardedMessage'
#FROM="Content-Type"
TO='Contasdfasdfs'
DATETIME=$(date +'%Y-%m-%d_%H%M%S'); 
DATETIME=$(date +%s%N);
OUTFILE="OUTFILE_${DATETIME}.eml"
cp "${INFILE}" "${OUTFILE}"

for line in $(cat ${INFILE} | egrep  -n "Content-Type: message/rfc822" | cut -d":" -f1 | sort -rn); do
	let i=i+1
	random=$(echo $RANDOM % 1000 + 1 | bc)
	echo Random: ${random}
	stamp=$(echo ${DATETIME} | md5sum | cut -d" " -f1 | xargs)
	echo "* Going for line ${line} ... ForwardedMessage${i}${stamp}${random}.eml" 
	sed -i "${OUTFILE}" -e ${line}'s/Content-Type: message\/rfc822/Content-Type: message\/rfc822; name="ForwardedMessage'${i}${stamp}${random}'.eml"/'
#	sed -i "${OUTFILE}" -e ${line}'s|${FROM}|'${TO}'|'


#	WERKEND: sed -i "${OUTFILE}" -e ${line}'s/Content-Type: message\/rfc822/Content-Type: message\/rfc822; name="ForwardedMessage'${i}'.eml"/'
done

#clear
#echo Result:
#cat ${OUTFILE}

#cat $INFILE | while read line; do 
#
#	let row=row+1
#	if $(echo "$line" | egrep -q "^${FROM}$"); then
#		let i=i+1
#		echo "${TO}_${i}.eml\"";
#		echo "${TO}_${i}.eml\"" >> ${OUTFILE}
#	else
#		echo "$line" >> ${OUTFILE}
#	fi
#done;


#if [ ${MESSAGES} -gt 0 ]
#	then
#	echo "ForwardedMessage.eml count: ${MESSAGES}";
#fi
#i=0
#while [ $i -lt ${MESSAGES} ]; do
#	echo $i
#	let i=i+1
#	
#done

#awk 'BEGIN {RS="jaja"; ORS=""} {print $0 ""++i}' ${INFILE}
#perl -ple 's/jaja/$n++/e' jaja.txt
#perl -ple '"JA*(AJA*";s/rfc822/$n++/e' test.eml | grep "Content-Type: message" -b5 -a5





if hash ripmime 2>/dev/null; then

	echo "ripMIME found. Therefore executing ...."
	ripmime --prefix --name-by-type  -i ${OUTFILE}  -d output
	mv --backup=numbered *output/*.eml ./

else

	echo "ripMIME not found. Therefore downloading..."
	wget http://www.pldaniels.com/ripmime/ripmime-1.4.0.10.tar.gz
	#http://www.pldaniels.com/ripmime/#downloads

fi


