#!/bin/bash

echo Renaming all files in current folder to incremented filenames

mkdir ../new_dir
find . -type f -name '*' |
    while read a; do
        ((c++))
        base="${a##*/}"
	ext="${a##*.}"
	to=$(echo "${a}" | sed 's|.\/||g')
#        cp "$a" "../new_dir/$(printf %.04d $c)_${to}"
	to=$(printf %.04d $c)
        echo "${a} wordt ${to}.${ext}"
        mv "${a}" "${to}.${ext}"
    done
