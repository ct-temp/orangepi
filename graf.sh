#!/bin/bash

source config_rrd.sh

rrdtool graph /var/www/html/$1.png \
--title "$TITLE $2 dnu" \
--start "end-$2d" \
--end "now-1min" \
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
"DEF:temp4=$RRD:rb:LAST" \
"CDEF:mtemp1=temp1,1,*" \
"CDEF:mtemp2=temp2,1,*" \
"CDEF:mtemp3=temp3,1,*" \
"CDEF:mtemp4=temp3,1,/,5,-" \
"CDEF:mtemp5=temp4,1,*" \
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
"GPRINT:mtemp3:MIN:          $MIN\\: %.0lf\n" \
"LINE2:mtemp5$BARVA4:$TEXT4\\:" \
"GPRINT:mtemp5:LAST:          $AKT\\: %.0lf" \
"GPRINT:mtemp5:AVERAGE:          $AVG\\: %.0lf" \
"GPRINT:mtemp5:MAX:          $MAX\\: %.0lf" \
"GPRINT:mtemp5:MIN:          $MIN\\: %.0lf\n"
