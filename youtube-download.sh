#!/bin/bash

mkdir ~/Desktop/youtube-video
cd ~/Desktop/youtube-video

youtube-dl $1

mediainfo * >> mediainfo.log

md5sum * > md5sum.log
