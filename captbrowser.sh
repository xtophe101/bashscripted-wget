#!/bin/bash

import -window root /tmp/tmp.png && convert -crop 1600x825+0+50 /tmp/tmp.png -draw 'rectangle 0,38 1920,55' -colorspace sRGB -pointsize 16 -fill white  -gravity None -annotate +5+103 "Screencapture `date +\%Y-\%m-\%d\ \%H:\%M:\%S`"  screencapture_`date +\%Y-\%m-\%d_\%H\%M\%S`.png


