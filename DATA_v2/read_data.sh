#!/bin/bash
FOLDER=/var/www/html

cd /usr/local/bin
python3 read_DHT.py


BME=`/usr/sbin/i2cdetect -y 0 | grep 76 | wc -l`
DHT=`cat $FOLDER/dhttmp.txt`
DHT=`printf "%0.0f\n" $DHT`
DS=`cat $FOLDER/ds.txt`




if [ $BME != 0 ]
then
       	python3 read_BME.py	
	echo "1" > $FOLDER/bme.txt 
else
	echo "0" > $FOLDER/bme.txt 
	echo "0" > $FOLDER/bmetmp.txt 
	echo "0" > $FOLDER/bmehum.txt 
	echo "0" > $FOLDER/bmepress.txt 
fi


if [ $DHT != 0 ]
then
	echo "1" > $FOLDER/dht.txt
else
	echo "0" > $FOLDER/dht.txt
	echo "0" > $FOLDER/dhttmp.txt
	echo "0" > $FOLDER/dhthum.txt
fi

/usr/local/bin/read_ip.sh
/usr/local/bin/read_DS.sh
/usr/local/bin/rosny_bod.sh
/usr/local/bin/rrd_insert.sh
