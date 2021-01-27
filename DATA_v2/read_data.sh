#!/bin/bash
FOLDER=/var/www/html

cd /usr/local/bin
python3 read_DHT.py


BME=`i2cdetect -y 0 | grep 76 | wc -l`
DHT=`cat $FOLDER/dhttmp.txt`
DHT=`printf "%0.0f\n" $DHT`
DS=`cat $FOLDER/ds.txt`




if [ $BME -eq 1 ]
then
	echo "1" > $FOLDER/bme.txt
       	python3 read_BME.py	
else
	echo "0" > $FOLDER/bme.txt 
fi


if [ $DHT != 0 ]
then
	echo "1" > $FOLDER/dht.txt
else
	echo "0" > $FOLDER/dht.txt
fi

/usr/local/bin/read_ip.sh
/usr/local/bin/read_DS.sh
/usr/local/bin/rosny_bod.sh


/usr/local/bin/rrd_insert.sh
