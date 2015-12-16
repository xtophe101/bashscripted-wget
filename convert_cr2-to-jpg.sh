#!/bin/bash
#http://marc.merlins.org/linux/technotes/cr2_dcraw_jhead.html
for i in *.CR2; do dcraw -c  $i | cjpeg -quality 80 > $i.jpg; done
