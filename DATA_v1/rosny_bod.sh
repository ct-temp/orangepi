#!/bin/sh


TMP=`cat /root/ramdisk/dhttmp.txt`
HUM=`cat /root/ramdisk/dhthum.txt`

ROSNYBOD=`/usr/local/bin/rosny_bod.py $TMP $HUM | grep Td | cut -d "=" -f 2`

ROSNYBOD=`printf "%0.2f\n" $ROSNYBOD`;
echo $ROSNYBOD > /root/ramdisk/rosny_bod.txt
