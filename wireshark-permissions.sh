#!/bin/bash

sudo dpkg-reconfigure wireshark-common
usermod -a -G wireshark $USER
chgrp wireshark /usr/bin/dumpcap
chmod 4750 /usr/bin/dumpcap
gpasswd -a $USER wireshark
