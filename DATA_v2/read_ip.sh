#!/bin/sh
FOLDER=/var/www/html/

ip a show dev eth0 | grep eth0 | grep inet | cut -d " " -f 6 > $FOLDER/eth0.txt
ip a show dev wlan0 | grep wlan0 | grep inet | cut -d " " -f 6 > $FOLDER/wlan0.txt

ETH=`cat $FOLDER/eth0.txt | wc -l`
WLAN=`cat $FOLDER/wlan0.txt | wc -l`

if [ $ETH -eq 0 ]
then
	echo "Neni" > $FOLDER/eth0.txt
fi


if [ $WLAN -eq 0 ]
then
	echo "Neni" > $FOLDER/wlan0.txt
fi
