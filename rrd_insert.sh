#!/bin/sh

START=`date +%s`
DSTEMP=`cat /root/ramdisk/dstmp.txt` 
DHTTMP=`cat /root/ramdisk/dhttmp.txt` 
DHTHUM=`cat /root/ramdisk/dhthum.txt` 
HTML=/var/www/html/index.html
BARVA1="#2E47C6"
BARVA2="#80ff00"
BARVA3="#ff0000"
TEXT1="  DSTMP"
TEXT2="  DHT TMP"
TEXT3="  DHT HUM"
DATE=`date +%a`" "` date +%F`" "`date +%R` #promenna s datumem a casem do hlavicek grafu
WIDTH=800
HEIGHT=340
AVG="pruměrně"
MAX="maximálně"
AKT="aktualně" 
MIN="minimalně"
DATEDATA=`date +%H":"%M":"%S" "%d"."%m"."%Y`


TXTDATA=/var/www/html/data.txt
RRD=/var/www/html/data.rrd
echo $DATEDATA" "$DSTEMP"       "$DHTTMP"       "$DHTHUM >> $TXTDATA


if [ ! -f $RRD ]; then
        rrdtool create $RRD --step 300 DS:dstmp:GAUGE:900:U:U DS:dhttmp:GAUGE:900:U:U DS:dhthum:GAUGE:900:U:U RRA:AVERAGE:0.5:1:105120 RRA:MAX:0.5:1:105120 RRA:MIN:0.5:1:105120
else
        rrdtool update $RRD "$START:$DSTEMP:$DHTTMP:$DHTHUM"

rrdtool graph /var/www/html/data.png \
--title "Data za posledních 24 hodin" \
--start 'end-24h' \
--end 'now-1min' \
--alt-y-grid \
--upper-limit '150' \
--lower-limit '0' \
--legend-position=south \
--rigid \
--slope-mode \
--vertical-label 'Počet' \
--imgformat 'PNG' \
--width=$WIDTH \
--height=$HEIGHT \
--font "DEFAULT:10:century schoolbook l" --watermark "Generováno : $DATE" \
"DEF:temp1=$RRD:dstmp:LAST" \
"DEF:temp2=$RRD:dhttmp:LAST" \
"DEF:temp3=$RRD:dhthum:LAST" \
"CDEF:mtemp1=temp1,1,*" \
"CDEF:mtemp2=temp2,1,*" \
"CDEF:mtemp3=temp3,10,/" \
"LINE3:mtemp1$BARVA1:$TEXT1\\:\n" \
"GPRINT:mtemp1:LAST:          $AKT\\: %.0lf\n" \
"GPRINT:mtemp1:AVERAGE:          $AVG\\: %.0lf\n" \
"GPRINT:mtemp1:MAX:          $MAX\\: %.0lf\n" \
"GPRINT:mtemp1:MIN:          $MAX\\: %.0lf\n" \
"LINE3:mtemp2$BARVA2:$TEXT2\\:\n" \
"GPRINT:mtemp2:LAST:          $AKT\\: %.0lf\n" \
"GPRINT:mtemp2:AVERAGE:          $AVG\\: %.0lf\n" \
"GPRINT:mtemp2:MAX:          $MAX\\: %.0lf\n" \
"GPRINT:mtemp2:MIN:          $MAX\\: %.0lf\n" \
"LINE3:mtemp3$BARVA3:$TEXT3\\:\n" \
"GPRINT:mtemp3:LAST:          $AKT\\: %.0lf\n" \
"GPRINT:mtemp3:AVERAGE:          $AVG\\: %.0lf\n" \
"GPRINT:mtemp3:MAX:          $MAX\\: %.0lf\n" \
"GPRINT:mtemp3:MIN:          $MAX\\: %.0lf\n"

fi


echo "<html>" > $HTML
echo "<head>" >> $HTML
echo "</head>" >> $HTML
echo "<body>" >> $HTML
echo "<p align='center'>" >> $HTML
echo "<table border='0' size='50%' aligne='center'>" >> $HTML
echo "<tr><td>Teplota DS :</td><td>$DSTEMP</td></tr>" >> $HTML
echo "<tr><td>Teplota DHT :</td><td>$DHTTMP</td></tr>" >> $HTML
echo "<tr><td>Vlhkost DHT :</td><td>$DHTHUM</td></tr>" >> $HTML
echo "</table>" >> $HTML
echo "<img src='data.png'>" >> $HTML
echo "<br>" >> $HTML
echo "<a href='data.txt'>Data v txt</a>" >> $HTML
echo "</p>" >> $HTML
