#!/bin/bash
cd /usr/local/bin

FOLDER=/var/www/html


python3 read_DHT.py
BME=`i2cdetect -y 0 | grep 76 | wc -l`
DHT=`cat /var/www/html/dhttmp.txt`
DHT=`printf "%0.0f\n" $DHT`


if [ $BME -eq 1 ]
then
	python3 read_BME.py
	echo "1" > $FOLDER/bme.txt 
else
	echo "0" > $FOLDER/bme.txt 
fi


if [ $DHT != 0 ]
then
	echo "1" > $FOLDER/dht.txt
else
	echo "0" > $FOLDER/dht.txt
fi
	
/usr/local/bin/read_DS.sh
/usr/local/bin/rosny_bod.sh
