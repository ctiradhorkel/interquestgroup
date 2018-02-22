#!/bin/bash

FILE=scan$1.xml

if [ ! -f $FILE ]; then
	nmap -F -oX $FILE $1 | awk '/open/'
else
	nmap -F -oX new$FILE $1 > /dev/null
	ndiff $FILE new$FILE
	mv -f new$FILE $FILE
fi