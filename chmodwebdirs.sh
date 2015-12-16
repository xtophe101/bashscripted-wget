#!/bin/bash

if [[ "$PWD" =~ "/var/www/" ]] && [[ "$PWD" =~ "/web" ]];
then
	chmod -R 755 *; find -type f -print0|xargs -0 chmod 644
	echo " Commando uitgevoerd op $PWD";
else
	echo " Je lijkt je niet te bevinden in een daartoe bedoelde directory!";
fi

