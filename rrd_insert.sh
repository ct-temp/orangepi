#!/bin/sh
# Pridam komentar
START=`date +%s`
DSTEMP=`cat /root/ramdisk/dstmp.txt` 
DHTTMP=`cat /root/ramdisk/dhttmp.txt` 
DHTHUM=`cat /root/ramdisk/dhthum.txt` 
HTML=/var/www/html/index.html
BARVA1="#2E47C6"
BARVA2="#80ff00"
BARVA3="#ff0000"
TEXT1="  DS TMP     "
TEXT2="  DHT TMP  "
TEXT3="  DHT HUM "
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
RRD_BACKUP=/root/backup_data/data.rrd


echo $DATEDATA" "$DSTEMP"       "$DHTTMP"       "$DHTHUM >> $TXTDATA


if [ ! -f $RRD ]; then
        if [ -f $RDD_BACKUP ]; then
                cp $RRD_BACKUP $RRD
                rrdtool update $RRD "$START:$DSTEMP:$DHTTMP:$DHTHUM"
        else
                rrdtool create $RRD --step 300 DS:dstmp:GAUGE:900:U:U DS:dhttmp:GAUGE:900:U:U DS:dhthum:GAUGE:900:U:U RRA:AVERAGE:0.5:1:105120 RRA:MAX:0.5:1:105120 RRA:MIN:0.5:1:105120
        fi
else
        rrdtool update $RRD "$START:$DSTEMP:$DHTTMP:$DHTHUM"
fi

rrdtool graph /var/www/html/data_den.png \
--title "OP3 - teplota vlhkost  za posledních 7 dnů" \
--start 'end-168h' \
--end 'now-1min' \
--color=BACK#BBBBBB \
--color=CANVAS#CCFFFF \
--color=GRID#732600 \
--color=MGRID#000000 \
--alt-y-grid \
--right-axis 1:5 \
--right-axis-format %1.1lf \
--right-axis-label 'Relativni vlhkost [%]' \
--upper-limit 40 \
--lower-limit 15 \
--legend-position=south \
--rigid \
--slope-mode \
--vertical-label 'Teplota [°C]' \
--imgformat 'PNG' \
--width=$WIDTH \
--height=$HEIGHT \
--font "DEFAULT:10:century schoolbook l" --watermark "Generováno : $DATE" \
"DEF:temp1=$RRD:dstmp:LAST" \
"DEF:temp2=$RRD:dhttmp:LAST" \
"DEF:temp3=$RRD:dhthum:LAST" \
"CDEF:mtemp1=temp1,1,*" \
"CDEF:mtemp2=temp2,1,*" \
"CDEF:mtemp3=temp3,1,*" \
"CDEF:mtemp4=temp3,1,/,5,-" \
"LINE3:mtemp1$BARVA1:$TEXT1\\:" \
"GPRINT:mtemp1:LAST:          $AKT\\: %.0lf" \
"GPRINT:mtemp1:AVERAGE:          $AVG\\: %.0lf" \
"GPRINT:mtemp1:MAX:          $MAX\\: %.0lf" \
"GPRINT:mtemp1:MIN:          $MIN\\: %.0lf\n" \
"LINE3:mtemp2$BARVA2:$TEXT2\\:" \
"GPRINT:mtemp2:LAST:          $AKT\\: %.0lf" \
"GPRINT:mtemp2:AVERAGE:          $AVG\\: %.0lf" \
"GPRINT:mtemp2:MAX:          $MAX\\: %.0lf" \
"GPRINT:mtemp2:MIN:          $MIN\\: %.0lf\n" \
"LINE2:mtemp4$BARVA3:$TEXT3\\:" \
"GPRINT:mtemp3:LAST:          $AKT\\: %.0lf" \
"GPRINT:mtemp3:AVERAGE:          $AVG\\: %.0lf" \
"GPRINT:mtemp3:MAX:          $MAX\\: %.0lf" \
"GPRINT:mtemp3:MIN:          $MIN\\: %.0lf\n"


rrdtool graph /var/www/html/data_14.png \
--title "OP3 - teplota vlhkost  za posledních 14 dnů" \
--start 'end-14d' \
--end 'now-1min' \
--color=BACK#BBBBBB \
--color=CANVAS#CCFFFF \
--color=GRID#732600 \
--color=MGRID#000000 \
--alt-y-grid \
--right-axis 1:5 \
--right-axis-format %1.1lf \
--right-axis-label 'Relativni vlhkost [%]' \
--upper-limit 40 \
--lower-limit 15 \
--legend-position=south \
--rigid \
--slope-mode \
--vertical-label 'Teplota [°C]' \
--imgformat 'PNG' \
--width=$WIDTH \
--height=$HEIGHT \
--font "DEFAULT:10:century schoolbook l" --watermark "Generováno : $DATE" \
"DEF:temp1=$RRD:dstmp:LAST" \
"DEF:temp2=$RRD:dhttmp:LAST" \
"DEF:temp3=$RRD:dhthum:LAST" \
"CDEF:mtemp1=temp1,1,*" \
"CDEF:mtemp2=temp2,1,*" \
"CDEF:mtemp3=temp3,1,*" \
"CDEF:mtemp4=temp3,1,/,5,-" \
"LINE3:mtemp1$BARVA1:$TEXT1\\:" \
"GPRINT:mtemp1:LAST:          $AKT\\: %.0lf" \
"GPRINT:mtemp1:AVERAGE:          $AVG\\: %.0lf" \
"GPRINT:mtemp1:MAX:          $MAX\\: %.0lf" \
"GPRINT:mtemp1:MIN:          $MIN\\: %.0lf\n" \
"LINE3:mtemp2$BARVA2:$TEXT2\\:" \
"GPRINT:mtemp2:LAST:          $AKT\\: %.0lf" \
"GPRINT:mtemp2:AVERAGE:          $AVG\\: %.0lf" \
"GPRINT:mtemp2:MAX:          $MAX\\: %.0lf" \
"GPRINT:mtemp2:MIN:          $MIN\\: %.0lf\n" \
"LINE2:mtemp4$BARVA3:$TEXT3\\:" \
"GPRINT:mtemp3:LAST:          $AKT\\: %.0lf" \
"GPRINT:mtemp3:AVERAGE:          $AVG\\: %.0lf" \
"GPRINT:mtemp3:MAX:          $MAX\\: %.0lf" \
"GPRINT:mtemp3:MIN:          $MIN\\: %.0lf\n"



rrdtool graph /var/www/html/data_mesic.png \
--title "OP3 - teplota vlhkost  za poslední měsíc" \
--start 'end-744h' \
--end 'now-1min' \
--color=BACK#BBBBBB \
--color=CANVAS#CCFFFF \
--color=GRID#732600 \
--color=MGRID#000000 \
--alt-y-grid \
--right-axis 1:5 \
--right-axis-format %1.1lf \
--right-axis-label 'Relativni vlhkost [%]' \
--upper-limit 40 \
--lower-limit 15 \
--legend-position=south \
--rigid \
--slope-mode \
--vertical-label 'Teplota [°C]' \
--imgformat 'PNG' \
--width=$WIDTH \
--height=$HEIGHT \
--font "DEFAULT:10:century schoolbook l" --watermark "Generováno : $DATE" \
"DEF:temp1=$RRD:dstmp:LAST" \
"DEF:temp2=$RRD:dhttmp:LAST" \
"DEF:temp3=$RRD:dhthum:LAST" \
"CDEF:mtemp1=temp1,1,*" \
"CDEF:mtemp2=temp2,1,*" \
"CDEF:mtemp3=temp3,1,*" \
"CDEF:mtemp4=temp3,1,/,5,-" \
"LINE3:mtemp1$BARVA1:$TEXT1\\:" \
"GPRINT:mtemp1:LAST:          $AKT\\: %.0lf" \
"GPRINT:mtemp1:AVERAGE:          $AVG\\: %.0lf" \
"GPRINT:mtemp1:MAX:          $MAX\\: %.0lf" \
"GPRINT:mtemp1:MIN:          $MIN\\: %.0lf\n" \
"LINE3:mtemp2$BARVA2:$TEXT2\\:" \
"GPRINT:mtemp2:LAST:          $AKT\\: %.0lf" \
"GPRINT:mtemp2:AVERAGE:          $AVG\\: %.0lf" \
"GPRINT:mtemp2:MAX:          $MAX\\: %.0lf" \
"GPRINT:mtemp2:MIN:          $MIN\\: %.0lf\n" \
"LINE2:mtemp4$BARVA3:$TEXT3\\:" \
"GPRINT:mtemp3:LAST:          $AKT\\: %.0lf" \
"GPRINT:mtemp3:AVERAGE:          $AVG\\: %.0lf" \
"GPRINT:mtemp3:MAX:          $MAX\\: %.0lf" \
"GPRINT:mtemp3:MIN:          $MIN\\: %.0lf\n"



rrdtool graph /var/www/html/data_2mesice.png \
--title "OP3 - teplota vlhkost  za 2 měsíce" \
--start 'end-60d' \
--end 'now-1min' \
--color=BACK#BBBBBB \
--color=CANVAS#CCFFFF \
--color=GRID#732600 \
--color=MGRID#000000 \
--alt-y-grid \
--right-axis 1:5 \
--right-axis-format %1.1lf \
--right-axis-label 'Relativni vlhkost [%]' \
--upper-limit 40 \
--lower-limit 15 \
--legend-position=south \
--rigid \
--slope-mode \
--vertical-label 'Teplota [°C]' \
--imgformat 'PNG' \
--width=$WIDTH \
--height=$HEIGHT \
--font "DEFAULT:10:century schoolbook l" --watermark "Generováno : $DATE" \
"DEF:temp1=$RRD:dstmp:LAST" \
"DEF:temp2=$RRD:dhttmp:LAST" \
"DEF:temp3=$RRD:dhthum:LAST" \
"CDEF:mtemp1=temp1,1,*" \
"CDEF:mtemp2=temp2,1,*" \
"CDEF:mtemp3=temp3,1,*" \
"CDEF:mtemp4=temp3,1,/,5,-" \
"LINE3:mtemp1$BARVA1:$TEXT1\\:" \
"GPRINT:mtemp1:LAST:          $AKT\\: %.0lf" \
"GPRINT:mtemp1:AVERAGE:          $AVG\\: %.0lf" \
"GPRINT:mtemp1:MAX:          $MAX\\: %.0lf" \
"GPRINT:mtemp1:MIN:          $MIN\\: %.0lf\n" \
"LINE3:mtemp2$BARVA2:$TEXT2\\:" \
"GPRINT:mtemp2:LAST:          $AKT\\: %.0lf" \
"GPRINT:mtemp2:AVERAGE:          $AVG\\: %.0lf" \
"GPRINT:mtemp2:MAX:          $MAX\\: %.0lf" \
"GPRINT:mtemp2:MIN:          $MIN\\: %.0lf\n" \
"LINE2:mtemp4$BARVA3:$TEXT3\\:" \
"GPRINT:mtemp3:LAST:          $AKT\\: %.0lf" \
"GPRINT:mtemp3:AVERAGE:          $AVG\\: %.0lf" \
"GPRINT:mtemp3:MAX:          $MAX\\: %.0lf" \
"GPRINT:mtemp3:MIN:          $MIN\\: %.0lf\n"



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
echo "<tr><td align='right'>Stazeni dat :</td><td align='right'><a href='data.txt'>download</a></td><td align='left'>&nbsp;</td></tr>" >> $HTML
echo "<tr><td bgcolor='black'>&nbsp;</td><td bgcolor='black'>&nbsp;</td><td align='left' bgcolor='black'>&nbsp;</td></tr></font>" >> $HTML

echo "</table>" >> $HTML
echo "<br>" >> $HTML
echo "<img src='data_den.png'>" >> $HTML
echo "<br>" >> $HTML
echo "<br>" >> $HTML
echo "<img src='data_14.png'>" >> $HTML
echo "<br>" >> $HTML
echo "<br>" >> $HTML
echo "<img src='data_mesic.png'>" >> $HTML
echo "<br>" >> $HTML
echo "<br>" >> $HTML
echo "<img src='data_2mesice.png'>" >> $HTML
echo "</html>" >> $HTML
