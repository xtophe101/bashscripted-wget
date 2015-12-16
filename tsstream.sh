#!/bin/bash

m3u8url=$1
m3u8url="http://l24m24f91623a600563687c3000000.676005ce9f5aca94.adaptive-e10c3a.npostreaming.nl/lmshieldv2/3/vara/rest/2015/VARA_101375971/VARA_101375971.ism/VARA_101375971-audio_eng=128000.m3u8"
m3u8url=$(echo "http:\/\/l2cm5dc925c05b0056368936000000.5132f12329a963ff.kpnsmoote1c.npostreaming.nl\/d\/live\/npo\/tvlive\/ned3\/ned3.isml\/ned3.m3u8" | sed 's/\\\//\//g')
m3u8url=$(echo "http:\/\/l2cm5dc925c05b0056368936000000.5132f12329a963ff.kpnsmoote1c.npostreaming.nl\/d\/live\/npo\/tvlive\/ned3\/ned3.isml\/ned3-audio=128000-video=900000.m3u8" | sed 's/\\\//\//g')
m3u8url="http://l2cm5dc925c05b0056368936000000.5132f12329a963ff.kpnsmoote1c.npostreaming.nl/d/live/npo/tvlive/ned3/ned3.isml/ned3-audio=128000-video=900000.m3u8"
echo ${m3u8url}

wget -q -O - "${m3u8url}" | grep -B1 "#EXT-X-ENDLIST" | head -n1


tsurl="http://l24m2d341de4c00056367fea000000.6f237a586fee6384.adaptive-e99c1a.npostreaming.nl/lmshieldv2/3/vara/rest/2015/VARA_101375971/VARA_101375971.ism/VARA_101375971-audio_eng=128000-video=999000-"
tsurl="http://l24m308d5e76890056368f6d000000.7a00dee446658d67.adaptive-e10c2b.npostreaming.nl/lmshieldv2/3/kroncrv/rest/2015/KN_1675235/KN_1675235.ism/KN_1675235-audio_eng=128000-video=1000000-"
rangeStart=1
rangeEnd=377

#for i in $(seq ${rangeStart} ${rangeEnd}); do  curl ${tsurl}${i}'.ts' -H 'Pragma: no-cache' -H 'DNT: 1' -H 'Accept-Encoding: gzip, deflate, sdch' -H 'Accept-Language: en-US,en;q=0.8,nl;q=0.6' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36' -H 'Accept: */*' -H 'Referer: http://media-service.vara.nl/player.php?id=348313&e=1&int=1&c=1' -H 'X-Requested-With: ShockwaveFlash/19.0.0.226' -H 'Connection: keep-alive' -H 'Cache-Control: no-cache' --compressed -o tsfile${i}.ts ; done


for i in $(seq ${rangeStart} ${rangeEnd}); do cat tsfile${i}.ts >> tsfiles_merged.ts; done


avconv -y -i "tsfiles_merged.ts" -f mp4 -r 29.97 -vcodec libx264 -preset slow -filter:v scale=704:384 -b:v 1000k -aspect 16:9 -flags +loop -cmp chroma -b:v 1250k -maxrate 1500k -bufsize 4M -bt 256k -refs 1 -bf 3 -coder 1 -me_method umh -me_range 16 -subq 7 -partitions +parti4x4+parti8x8+partp8x8+partb8x8 -g 250 -keyint_min 25 -level 30 -qmin 10 -qmax 51 -qcomp 0.6 -trellis 2 -sc_threshold 40 -i_qfactor 0.71 -acodec libvo_aacenc -b:a 112k -ar 48000 -ac 2 "tsfiles_merged.mp4"




curl 'http://l24m2d341de4c00056367fea000000.6f237a586fee6384.adaptive-e99c1a.npostreaming.nl/lmshieldv2/3/vara/rest/2015/VARA_101375971/VARA_101375971.ism/VARA_101375971-audio_eng=128000-video=999000-'${i}'.ts' -H 'Pragma: no-cache' -H 'DNT: 1' -H 'Accept-Encoding: gzip, deflate, sdch' -H 'Accept-Language: en-US,en;q=0.8,nl;q=0.6' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36' -H 'Accept: */*' -H 'Referer: http://media-service.vara.nl/player.php?id=348313&e=1&int=1&c=1' -H 'X-Requested-With: ShockwaveFlash/19.0.0.226' -H 'Connection: keep-alive' -H 'Cache-Control: no-cache' --compressed


