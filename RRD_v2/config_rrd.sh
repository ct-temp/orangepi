FOLDER=/var/www/html/
START=`date +%s`
DSTEMP=`cat $FOLDER/dstmp.txt` 
DHTTMP=`cat $FOLDER/dhttmp.txt` 
DHTHUM=`cat $FOLDER/dhthum.txt` 
ROSNYBOD=`cat $FOLDER/dhtrb.txt`

BME=`cat $FOLDER/bme.txt`
if [ $BME -eq 1 ]
then
	BMETMP=`cat $FOLDER/bmetmp.txt`
	BMEHUM=`cat $FOLDER/bmehum.txt`
	BMEPRESS=`cat $FOLDER/bmepress.txt`
	BMERB=`cat $FOLDER/bmerb.txt`
fi

HTML=/var/www/html/index.html
BARVA1="#2E47C6"
BARVA2="#80ff00"
BARVA3="#ff0000"
BARVA4="#FFF101"
TEXT1="  DS TMP     "
TEXT2="  DHT TMP  "
TEXT3="  DHT HUM "
TEXT4="  Rosny bod "
TITLE="OP3 - teplota vlhkost za"
DATE=`date +%a`" "` date +%F`" "`date +%R` #promenna s datumem a casem do hlavicek grafu
WIDTH=800
HEIGHT=340
AVG="pruměrně"
MAX="maximálně"
AKT="aktualně" 
MIN="minimalně"
DATEDATA=`date +%H":"%M":"%S" "%d"."%m"."%Y`
TXTDATA=/var/www/html/data.txt
TXTDATABME=/var/www/html/bmedata.txt
RRD=/var/www/html/data.rrd
RRD_BACKUP=/root/backup_data/data.rrd

