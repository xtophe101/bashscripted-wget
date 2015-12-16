#!/bin/bash

vm="WindowsXP"

ISODATE=$(date +'%Y-%m-%d_%H%M%S');

#https://www.virtualbox.org/wiki/Network_tips
VBoxManage modifyvm ${vm} --nictrace1 on --nictracefile1 /home/${USER}/Documents/${ISODATE}_vbox-tcpdump.pcap
VirtualBox -startvm ${vm}
VBoxManage modifyvm ${vm} --nictrace1 off
