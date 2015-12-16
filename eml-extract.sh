#!/bin/bash

#nodig: sudo apt-get install uudeview

mkdir -p ~/Desktop/eml/
uudeview -i +a +o +e .eml "$1" -p ~/Desktop/eml
