#!/bin/sh

$url = $1 
# start a server with a specific DISPLAY
vncserver :11 -geometry 1024x768

# start firefox in this vnc session
firefox --display :11

# read URLs from a data file in a loop
count=1
while read url
do
    # send URL to the firefox session
    firefox --display :11 $url

    # take a picture after waiting a bit for the load to finish
    sleep 5
    import -window root image$count.jpg

    count=`expr $count + 1`
done < url_list.txt

# clean up when done
vncserver -kill :11
