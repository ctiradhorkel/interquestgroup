#!/bin/bash

FILE=scan$1

if [ ! -f $FILE ]; then 
	nmap -F -oG - $1 | awk '/open/{ s="*Target - " $2 ": Full scan results:*\n";for (a=5;a<=NF-4;a++) s=s "Host: " $2 "    Ports: " substr($a,1,length($a)-4) "\n";print s}' > $FILE
	cat $FILE
else
	nmap -F -oG - $1 | awk '/open/{ s="*Target - " $2 ": Full scan results:*\n";for (a=5;a<=NF-4;a++) s=s "Host: " $2 "    Ports: " substr($a,1,length($a)-4) "\n";print s}' > new$FILE
	oldcheck=($(md5sum $FILE))
	newcheck=($(md5sum new$FILE))
	if [ "$oldcheck" = "$newcheck" ]; then
		echo '*Target - $1: No new records found in the last scan.*'
	else
		cat new$FILE
		mv -f new$FILE $FILE
	fi
fi