 #! /bin/bash
  OUTF=rem-duplicates.sh;
  echo "#! /bin/sh" > $OUTF;
  echo ""          >> $OUTF;
  find "$@" -type f -print0 | xargs -0 -n1 md5sum | sort --key=1,32 | uniq -w 32 -d --all-repeated=separate | sed -r 's/^[0-9a-f]*( )*//;s/([^a-zA-Z0-9./_-])/\\\1/g;s/(.+)/#rm \1/' | tac | sed ':a;N;$!ba;s/\([a-zA-Z]\{1,\}\)\n#/\1\n/g' >>$OUTF;
# find "$@" -type f -print0 | xargs -0 -n1 md5sum | sort --key=1,32 | uniq -w 32 -d --all-repeated=separate | sed -r 's/^[0-9a-f]*( )*//;s/([^a-zA-Z0-9./_-])/\\\1/g;s/(.+)/#rm \1/'  | tac | sed ':a;N;$!ba;s/\([a-zA-Z]\{1,\}\)\n#/\1\n/g' >> $OUTF;
  chmod a+x $OUTF


#cat $OUTF | sed ':a;N;$!ba;s/\([a-z]\{1,\}\)\n#/\1\n/g'


