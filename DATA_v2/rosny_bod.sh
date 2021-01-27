#!/bin/sh
FOLDER=/var/www/html/


BME=`i2cdetect -y 0 | grep 76 | wc -l`
DHT=`cat /var/www/html/dht.txt`

if [ $BME -eq 1 ]
then
    TMP=`cat $FOLDER/bmetmp.txt`
    HUM=`cat $FOLDER/bmehum.txt`
    ROSNYBOD=`python3 /usr/local/bin/rosny_bod.py $TMP $HUM | grep Td | cut -d "=" -f 2`
    ROSNYBOD=`printf "%0.1f\n" $ROSNYBOD`;
    echo $ROSNYBOD > $FOLDER/bmerb.txt
fi


if [ $DHT -eq 1 ]
then
    TMP=`cat $FOLDER/dhttmp.txt`
    HUM=`cat $FOLDER/dhthum.txt`
    ROSNYBOD=`python3 /usr/local/bin/rosny_bod.py $TMP $HUM | grep Td | cut -d "=" -f 2`
    ROSNYBOD=`printf "%0.1f\n" $ROSNYBOD`;
    echo $ROSNYBOD > $FOLDER/dhtrb.txt
fi

