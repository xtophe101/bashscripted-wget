#!/bin/bash


OIFS="$IFS";
IFS=$'\n';
for n in $(find . -maxdepth 1 -type f  -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.gif' ); 
        do
		gpspos=$(exiftool "${n}" | sed -n -e 's/^GPS Position[ ]*: \(.*\)/\1/p')
		       Ogpspos=${gpspos}
			gpspos=$(echo ${gpspos} | sed 's/deg \|\" //g')
			gpspos=$(echo ${gpspos} | sed "s/'//g")
	 	 	 langL=$(echo ${gpspos} | sed -n -e 's/.*\(N\|S,\).*/\1/p')
			  latL=$(echo ${gpspos} | sed -n -e 's/.*\(E\|W\)$/\1/p')

	 	 	 langL=$(echo ${gpspos} | sed -n -e 's/.*\(N,\).*//p' | xargs)
	 	 	 langL=$(echo ${gpspos} | sed -n -e 's/.*\(S,\).*/-/p' | xargs)
	 	 	 latL=$(echo ${gpspos} | sed -n -e 's/.*\(E\)$//p' | xargs)
	 	 	 latL=$(echo ${gpspos} | sed -n -e 's/.*\(W\)$/-/p' | xargs)

			gpspos=$(echo ${gpspos} | sed "s/[N\|S\|W\|E]//g")
			 langC=$(echo ${gpspos} | cut -d"," -f1 | xargs)
			  latC=$(echo ${gpspos} | cut -d"," -f2 | xargs)
			 langD=$(echo ${langC}  | awk '{split($0,c," ");} {print $1+($2/60)+($3/3600)}' | xargs)
			  latD=$(echo ${latC}   | awk '{split($0,c," ");} {print $1+($2/60)+($3/3600)}' | xargs)
#			 langD=$(echo ${langD} | awk '{printf("%.5f",$1 + 0.5)}' );
#			  latD=$(echo ${latD}  | awk '{printf("%.5f",$1 + 0.5)}' );

		if [[ "${gpspos}" != "" ]]; then

	#wget -q -O - "http://maps.googleapis.com/maps/api/geocode/json?sensor=true&latlng=53.3433,-6.26779" | python -mjson.tool | grep "formatted_address" | sed -n 3,1p | cut -d":" -f2 | sed 's/,//g' | xargs
#http://maps.googleapis.com/maps/api/geocode/xml?latlng=53.244921,-2.479539&result_type=locality&api=AIzaSyCV3vpNxzGrisDHO_gxctu1aCGKm76FUks
#		gpstxt=$(wget -q -O - "https://maps.googleapis.com/maps/api/geocode/json?&result_type=locality&language=NL&result_type=administrative_area_level_1&location_type=APPROXIMATE&key=AIzaSyCV3vpNxzGrisDHO_gxctu1aCGKm76FUks&sensor=true&latlng=${langL}${langD},${latL}${latD}" | python -mjson.tool | grep "formatted_address" | head -n1 | cut -d":" -f2 | sed 's/,//g' | sed 's/ Nederland//g' | xargs)
#			echo ${n} - ${gpsconv} - ${lang:0:1} - ${lat}
			echo "${n} - ${langL}${langD},${latL}${latD}"
#			mkdir -p "${gpstxt}"
#			mv -i "${n}" "${gpstxt}/"
		fi


        done;

IFS="$IOFS"

