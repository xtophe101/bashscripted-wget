#!/bin/bash

function valid_ip()
{
    local  ip=$1
    local  stat=1

    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
            && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
    fi
    return $stat
}

# If run directly, execute some tests.
if [[ "$1" == 'valid_ip' ]]; then
	IP=$1
#	echo # IP = $1
else
#	IP=$(ping -c 1 $1 | sed -E 's/^.*\(([^)][0-9\.]+)\).*$/\1/' | head -n2 | tail -n1)
	IP=$(dig +short $1 | head -n1)
#	echo # $1 has $IP
fi

COMPANY=$(whois ${IP} | grep role -m1 | cut -d":" -f2 | sed -e 's/^ *//' -e 's/ *$//')
if [ -z "$COMPANY" ]; then
	COMPANY=$(whois ${IP} | grep descr -m1 | cut -d":" -f2 | sed -e 's/^ *//' -e 's/ *$//')
fi
if [ -z "$COMPANY" ]; then
	COMPANY=$(whois ${IP} | grep OrgName -m1 | cut -d":" -f2 | sed -e 's/^ *//' -e 's/ *$//')
fi
COUNTRY=$(whois $IP | grep -i country | awk '{ print substr( $0,length($0)-1,2) }' | uniq -i | sed ':a;N;$!ba;s/\n/ /g' )
echo -e "${IP}\t${COUNTRY}\t${COMPANY}"
