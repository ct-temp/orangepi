#!/bin/bash


CIDLO=`ls -la /sys/bus/w1/devices/w1_bus_master1/ | grep 28 | cut -d " " -f 14`
FILE=/var/www/html/dstmp.txt

if [[ -f "/sys/bus/w1/devices/$CIDLO/w1_slave" ]];then
	DSTMP=`cat /sys/bus/w1/devices/$CIDLO/w1_slave | grep "t=" | cut -d "=" -f 2`
	DSTMP=`echo "scale=1; $DSTMP / 1000" | bc`
	echo $DSTMP > $FILE
	echo "1" > /var/www/html/ds.txt
else
	echo "0" > /var/www/html/ds.txt 
	echo "0" > /var/www/html/dstmp.txt
fi
