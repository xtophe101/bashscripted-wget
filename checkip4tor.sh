#!/bin/bash

#https://check.torproject.org/exit-addresses

list=$(wget https://check.torproject.org/exit-addresses -q -O - > /tmp/torexitnodes.log)
ip=$1

if [[ ${ip} == '' ]]; then
    ip=$(ip.sh)
fi

echo -e "\n\n*******************************************************";
echo Using https://check.torproject.org/exit-addresses
echo Checking ${ip}

if grep -q ${ip} /tmp/torexitnodes.log; then
    echo "The I P address is part of a tor exit node" | festival --tts
    echo "*******************************************************";
    echo "Found ${ip} in tor exit-node list:"
    grep ${ip} /tmp/torexitnodes.log -b5 -a5
    echo "*******************************************************";
else
    echo "The given I P address is not an exit node" | festival --tts
    echo "*******************************************************";
    echo "${ip} not in tor exit-node list"
    echo "*******************************************************";
fi

echo -e "\n\n"
