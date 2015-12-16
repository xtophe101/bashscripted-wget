#!/bin/bash

maxdepth=1
datebefore="2013-01-01"
dateafter="2015-01-01"

filesPerDimension()
{
	# filefrequency per image dimension
	command -v foo >/dev/null 2>&1 || { echo >&2 "I require foo but it's not installed.  Aborting."; exit 1; }
	find . -maxdepth ${maxdepth} -type f -exec stat "{}" --printf "%y\n" \; | cut -d"-" -f1-2  # | sort | uniq -c | sort -n
}

filesBetweenDates()
{
	find . -type f -maxdepth 1 -newermt ${datebefore} ! -newermt ${dateafter}
}

filesPerExtension()
{
	# filefrequency per extension
	find . -maxdepth ${maxdepth} -type f | rev | cut -d . -f1 | rev # | sort | uniq -ic | sort -rn
}

filesPerMonth()
{
	# filefrequency per month
	find . -maxdepth ${maxdepth} -type f -exec stat "{}" --printf "%y\n" \; | cut -d"-" -f1-2  # | sort | uniq -c | sort -n
}

filesPerYear()
{
	# filefrequency per year
	find . -maxdepth ${maxdept} -type f -exec stat "{}" --printf "%y\n" \; | cut -d"-" -f1  # | sort | uniq -c | sort -n
}


# Preview:
#echo "Files per extension:" 
#filesPerExtension | tr " " "\n" | sort | uniq -ic | sort

#echo "Files per month:"
#filesPerMonth | tr " " "\n" | sort | uniq -ic | sort


echo "y - create folders by (Y)ear"
echo "m - create folders by (M)onth"
echo "e - create folters by (E)xtension"
echo "s - create folters by (S)ize"

read -p "How do you wish to arrange? " -n 1 -r
echo    # (optional) move to a new line

if [[ $REPLY =~ ^[Yy]$ ]]
then
	filesPerYear
elif [[ $REPLY =~ ^[Mm]$ ]]
then

	#alternative: jhead -n'/full/path/to/your_output_directory/%Y/%m_%B/%d-%T'

	yearmonths=$(filesPerMonth)
	for yyyymm in $(echo -n ${yearmonths} | tr " " "\n" | sort | uniq -i | grep -e "[0-9-]");
	do
		echo "Year-Month: $yyyymm"
		datebefore=$(date -d "${yyyymm}-01 +1 month"  +"%Y%m%d %H:%M:%S")
		dateafter=$(date -d "${yyyymm}-01"  +"%Y%m%d %H:%M:%S")
		echo "${datebefore} and ${dateafter}"
		mkdir -p "${yyyymm}"
		find ./ -maxdepth 1 -type f -newermt "${dateafter}" ! -newermt "${datebefore}" -exec mv "{}" "${yyyymm}/" \;
		echo 'find ./ -maxdepth 1 -type f -newermt "${dateafter}" ! -newermt "${datebefore}" -exec mv -i "{}" "${yyyymm}/" \;'
	done;
elif [[ $REPLY =~ ^[Ee]$ ]]
then
	extensions=$(filesPerExtension)
	for ext in $(echo -n ${extensions} | tr " " "\n" | sort | uniq -i | grep -e "[A-Za-z0-9]");
	do
		echo "Extensie: $ext"
		mkdir -p "${ext}"
		echo 'find ./ -maxdepth 1 -type f -iname "*.${ext}" -exec mv "{}" "${ext}/" \;'
		find ./ -maxdepth 1 -type f -iname "*.${ext}" -exec mv "{}" "${ext}/" \;


	done;
elif [[ $REPLY =~ ^[Ss]$ ]]
then
	dimension=$(filesPerDimension)
#	for ext in $(echo -n ${extensions} | tr " " "\n" | sort | uniq -i | grep -e "[A-Za-z0-9]");
#	do
#		echo "Extensie: $ext"
#		mkdir -p "${ext}"
#		echo 'find ./ -maxdepth 1 -type f -iname "*.${ext}" -exec mv "{}" "${ext}/" \;'
#		find ./ -maxdepth 1 -type f -iname "*.${ext}" -exec mv "{}" "${ext}/" \;
#
#
#	done;
fi




#read -p "Are you sure? " -n 1 -r
#echo    # (optional) move to a new line
#if [[ $REPLY =~ ^[Yy]$ ]]
#then
#    # do dangerous stuff
#fi




