#!/bin/bash

# PURPOSE:
# RETURN COUNTRY CODES FROM WHOIS AND GEO-IP FROM AN IP-ADDRESS OR DOMAINNAME

# USAGE:
# ipcountry.sh {FILE WITH IP ADDRESSES OR DOMAINNAMES}

# OUTPUTFORMAT:
# TAB SEPARATED: "${INPUT}\t${GEOIPCOUNTRY}\t${WHOISCOUNTRY}\t${DOMAIN}\t${ERR}"

# EXAMPLE OUTPUT:
#
#IP	GEOIPCOUNTRY	WHOISCOUNTRY	DOMAIN
#119.63.193.130	JP	JP
#119.63.193.194	JP	JP
#			test	UNKNOWN DOMAIN
#119.63.193.131	JP	JP
#119.63.193.132	JP	JP
#194.109.6.40	NL	NL	mail.xs4all.nl
#			subdomain.cnn.com	UNKNOWN DOMAIN
#119.63.193.195	JP	JP
#			a.a.a.a	UNKNOWN DOMAIN
#157.166.226.26	US	US	cnn.com
#119.63.193.196	JP	JP
#178.154.243.118	RU	RU
#87.195.108.2	NL	NL
#192.99.149.88	CA	CA
#94.142.215.98	NL	NL



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



echo -e "IP\tGEOIPCOUNTRY\tWHOISCOUNTRY\tDOMAIN"

for INPUT in $(cat $1); do

	DOMAIN=""
	ERR=""
	WHOISCOUNTRY=""
	GEOIPCOUNTRY=""

	if valid_ip $INPUT; then
		IP=$INPUT
	else
		DOMAIN="$INPUT"
		IP=$(dig +short $DOMAIN | head -n1)
		if [[ -z "$IP" ]]; then
			ERR="UNKNOWN DOMAIN"
		fi
	fi

	if [[ "$ERR" == "" ]]; then
		WHOISCOUNTRY=$(whois $IP | grep -i country | awk '{ print substr( $0,length($0)-1,2) }' | uniq -i | sed ':a;N;$!ba;s/\n/ /g' )

		if [[ $(dpkg-query -W -f='${Status}' geoip-bin 2>/dev/null | grep -c "ok installed") == 1 ]]; then
			GEOIPCOUNTRY=$(geoiplookup ${IP} | xargs | sed -n 's/.*\: \([A-Z]\{2\}\).*/\1/p')
		else
			GEOIPCOUNTRY="(install geoip-bin!)"
		fi
	fi

	echo -e "${IP}\t${GEOIPCOUNTRY}\t${WHOISCOUNTRY}\t${DOMAIN}\t${ERR}"

done
