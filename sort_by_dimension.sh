#!/bin/bash


PANORATIO=5.00;

for jf in {$PREFIX,_,AFBEELDING,foto,P,IMG,IMA,DSC,Screenshot}*.{JPG,jpg,jpeg,png}; 
	do

	if [ -f "$jf" ]; then
			DIMENSIONS=$(identify "$jf" | cut -d" " -f3);
			WIDTH=$(echo $DIMENSIONS | cut -d"x" -f1);
			HEIGHT=$(echo $DIMENSIONS | cut -d"x" -f2);

			#echo $jf has $WIDTH and $HEIGHT;
		
			if [ $HEIGHT -gt 0 ] || [ $WIDTH -gt 0 ]; 		
			then

				if [ $HEIGHT  -gt  $WIDTH ];
					then 
					RATIO=`awk 'BEGIN{printf("%0.2f", '$HEIGHT' / '$WIDTH')}'`
#					FOLDER="$HEIGHT"x"$WIDTH"
					LARGEST=$HEIGHT;
					SMALLEST=$WIDTH;
					ORIENTATION="PORTRAIT";
				else 
					RATIO=`awk 'BEGIN{printf("%0.2f", '$WIDTH' / '$HEIGHT')}'`
#					FOLDER="$WIDTH"x"$HEIGHT";
					LARGEST=$WIDTH;
					SMALLEST=$HEIGHT;
					ORIENTATION="LANDSCAPE";
				fi;
				
				if [ $LARGEST  -gt  800 ] && [ $(echo "$RATIO < 1.8" | bc -l ) ];
					then
					FOLDER="large"
				fi;

				if [ $LARGEST  -le  800 ] && [ $(echo "$RATIO < 1.8" | bc -l ) ];
					then
					FOLDER="normal"
				fi;


				if [ $LARGEST  -lt  640 ] && [ $(echo "$RATIO < 1.8" | bc -l ) ];
					then
					FOLDER="small"
				fi;

				if [ $LARGEST  -lt  450 ];
					then
					FOLDER="tiny"
				fi;



				if [ $LARGEST  -eq  800 ] && [ $(echo "$RATIO = 1.78") ];
					then
					FOLDER="screencapture"
				fi;


				if [ $SMALLEST  -ge 600 ] && ([ $(echo "$RATIO = 1.33") ] || [ $(echo "$RATIO = 1.77") ]);
					then
					FOLDER="photo"
				fi;



				if [ $(echo "$RATIO = 1.00") ];
					then
					FOLDER="square"
				fi;





				if [ -n "$FOLDER" ]; then
					echo $jf $ORIENTATION \($RATIO\) $FOLDER $WIDTH x $HEIGHT; 
					mkdir -p $FOLDER;
					mv "$jf" $FOLDER;
				fi;

			fi;

	fi;
done;
