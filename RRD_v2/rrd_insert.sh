#!/bin/bash

source /usr/local/bin/config_rrd.sh

echo $DATEDATA"|"$DSTEMP"|"$DHTTMP"|"$DHTHUM"|"$ROSNYBOD >> $TXTDATA


if [ ! -f "$RRD" ]; then
        if [ ! -f "$RRD_BACKUP" ]; then
                rrdtool create $RRD --step 300 DS:dstmp:GAUGE:900:U:U DS:dhttmp:GAUGE:900:U:U DS:dhthum:GAUGE:900:U:U DS:rb:GAUGE:900:U:U RRA:AVERAGE:0.5:1:105120 RRA:MAX:0.5:1:105120 RRA:MIN:0.5:1:105120
        else
                cp $RRD_BACKUP $RRD
                cp /root/backup_data/data.txt /var/www/html/
		rrdtool update $RRD "$START:$DSTEMP:$DHTTMP:$DHTHUM:$ROSNYBOD"
        fi
else
        rrdtool update $RRD "$START:$DSTEMP:$DHTTMP:$DHTHUM:$ROSNYBOD"
fi


/usr/local/bin/graf.sh data_1_den 1 
/usr/local/bin/graf.sh data_7_den 7 
/usr/local/bin/graf.sh data_14_den 14 
/usr/local/bin/graf.sh data_30_den 30 
/usr/local/bin/graf.sh data_60_den 60 
	

echo "<html>" > $HTML
echo "<head>" >> $HTML
echo "<title>Vhkost teplota</title>" >> $HTML
echo "<meta http-equiv='refresh' content='600' />" >> $HTML
echo "</head>" >> $HTML
echo "<body>" >> $HTML
echo "<p align='center'>" >> $HTML
echo "<table border='0' width='981' style='font-family:\"Courier New\", Courier, monospace' cellspacing='0'  cellpadding='5'>" >> $HTML
	

echo "<html>" > $HTML
echo "<head>" >> $HTML
echo "<title>Vhkost teplota</title>" >> $HTML
echo "<meta http-equiv='refresh' content='600' />" >> $HTML
echo "</head>" >> $HTML
echo "<body>" >> $HTML
echo "<p align='center'>" >> $HTML
echo "<table border='0' width='981' style='font-family:\"Courier New\", Courier, monospace' cellspacing='0'  cellpadding='5'>" >> $HTML
echo "<tr><td align='right' bgcolor='black' width='700' ><font color='white'>Merene hodnoty</font></td><td align='right' bgcolor='black'><font color='white'>Aktualne</font></td><td align='left' bgcolor='black'>&#8451</td></tr></font>" >> $HTML
echo "<tr><td align='right'>Teplota DS :</td><td align='right'>$DSTEMP</td><td align='left'>&#8451</td></tr>" >> $HTML
echo "<tr><td align='right'>Teplota DHT :</td><td align='right'>$DHTTMP</td><td align='left'>&#8451</td></tr>" >> $HTML
echo "<tr><td align='right'>Vlhkost DHT :</td><td align='right'>$DHTHUM</td><td align='left'>%</td></tr>" >> $HTML
echo "<tr><td align='right'>Rosny bod DTH :</td><td align='right'>$ROSNYBOD</td><td align='left'>&#8451</td></tr>" >> $HTML

BME=`cat $FOLDER/bme.txt`
if [ $BME -eq 1 ]
then
        echo $DATEDATA"|"$BMETMP"|"$BMEHUM"|"$BMEPRESS"|"$BMERB >> $TXTDATABME
	echo "<tr><td align='right'>Teplota BME280 :</td><td align='right'>$BMETMP</td><td align='left'>&#8451</td></tr>" >> $HTML
	echo "<tr><td align='right'>Vlhkost BME280 :</td><td align='right'>$BMEHUM</td><td align='left'>%</td></tr>" >> $HTML
	echo "<tr><td align='right'>Rosny bod BME280 :</td><td align='right'>$BMERB</td><td align='left'>&#8451</td></tr>" >> $HTML
	echo "<tr><td align='right'>Tlak BME280 :</td><td align='right'>$BMEPRESS</td><td align='left'>HPa</td></tr>" >> $HTML
fi

echo "<tr><td align='right'>Stazeni dat :</td><td align='right'><a href='data.txt'>download</a></td><td align='left'>&nbsp;</td></tr>" >> $HTML
echo "<tr><td bgcolor='black'>&nbsp;</td><td bgcolor='black'>&nbsp;</td><td align='left' bgcolor='black'>&nbsp;</td></tr></font>" >> $HTML

echo "</table>" >> $HTML
echo "<br>" >> $HTML
echo "<img src='data_1_den.png'>" >> $HTML
echo "<br>" >> $HTML
echo "<br>" >> $HTML
echo "<img src='data_7_den.png'>" >> $HTML
echo "<br>" >> $HTML
echo "<br>" >> $HTML
echo "<img src='data_14_den.png'>" >> $HTML
echo "<br>" >> $HTML
echo "<br>" >> $HTML
echo "<img src='data_30_den.png'>" >> $HTML
echo "<br>" >> $HTML
echo "<br>" >> $HTML
echo "<img src='data_60_den.png'>" >> $HTML
echo "</html>" >> $HTML

