#!/bin/bash

EXTIP=$(wget http://myip.xtophe.com/tools/ -q -O -); 
NOW=$(date +'%Y-%m-%d_%H%M_')

#tcpdump -i any -n -p -s 0 -w ${NOW}_${EXTIP}_tcpdump-capture.pcap
tcpdump -i any -n -p -s 0 -w $(date +'%Y-%m-%d_%H%M_')$(wget http://myip.xtophe.com/tools/ -q -O -)_tcpdump-capture.pcap




#tcpdump -c 20 -s 0 -i eth1 -A host 192.168.1.1 and tcp port http
#
#The parameter breakdown:
#-c 20: Exit after capturing 20 packets.
#-s 0: Don't limit the amount of payload data that is printed out. Print it all.
#-i eth1: Capture packets on interface eth1
#-A: Print packets in ASCII.
#host 192.168.1.1: Only capture packets coming to or from 192.168.1.1.
#and tcp port http: Only capture HTTP packets.
#POSTED
