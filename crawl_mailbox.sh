#!/bin/bash

# http://www.isartor.org/wiki/Crawl_your_Thunderbird_mailbox_to_add_email_addresses_to_your_addressbook
# ./crawl_mailbox.sh ~/.thunderbird/[profile]/ImapMail/email.example.com/INBOX-1 > ~/crawled_addressbook.ldif


timestamp=`date +%s`
#echo $2
#exit


grep "^From: " $1 | grep \< | awk -F \< {'print $2'} | sed 's/>//' | grep \@  | grep -v = | sort | uniq -i | while read EMAIL; do

if [[ $2 == 'ldif' ]]; then
	  echo "dn: mail=$EMAIL"
	  echo "objectclass: top"
	  echo "objectclass: person"
	  echo "objectclass: organizationalPerson"
	  echo "objectclass: inetOrgPerson"
	  echo "objectclass: mozillaAbPersonAlpha"
	  echo "mail: $EMAIL"
	  echo "modifytimestamp: $timestamp"
	  echo ""
else
	echo $EMAIL
fi

done
