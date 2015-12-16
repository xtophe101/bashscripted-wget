#!/bin/bash

url=$1
file=$2

wkhtmltopdf -B 0 -T 0 -L 0 -R 0 --page-height 200mm --page-width 220mm "${url}" "${file}.pdf"
convert -density 200x200 -quality 300 "${file}.pdf" "${file}.png"
