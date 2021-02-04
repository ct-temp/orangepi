#!/bin/bash

echo "Instaluji balíčky do systému"
apt-get -y install python3-distutils python3-dev i2c-tools libi2c-dev libjpeg-dev libjpeg-tools libfreetype-dev python3-pip python3-smbus rrdtool lighttpd chrony python3-numpy

echo "Instaluji GPIo pro Zero"
cd ~
git clone https://github.com/nvl1109/orangepi_zero_gpio.git
cd orangepi_zero_gpio
python3 setup.py install

cd ~/orangepi 

echo "Instaluji balíčky do Pythonu"
pip3 install virtualenv Pillow smbus2 psutil setuptools

echo "Kopíruji data"
cp -rf DATA_v2/*.py /usr/local/bin/
cp -rf DATA_v2/*.sh /usr/local/bin/
cp -rf RRD_v2/* /usr/local/bin/
cp -rf sync_data.sh /usr/local/bin/

echo "Nastavuji oprávnění"
chmod 755 /usr/local/bin/*.sh

echo "Vytvarim tmpfs"
FSTAB=`cat /etc/fstab | grep "tmpfs\ /var/www/html" | wc -l`
if [ $FSTAB -eq 0 ];then
	echo "tmpfs /var/www/html tmpfs defaults,size=20m 0 0" >> /etc/fstab
else
	echo "TMPFS exist";
fi

echo "Settings CRON"
CSYNC=`crontab -l | grep sync_data.sh| wc -l`
CDATA=`crontab -l | grep read_data.sh| wc -l`
if [ $CSYNC -eq 0 ]; then
	(crontab -l 2>/dev/null; echo "59 * * * * /usr/local/bin/sync_data.sh") | crontab -
else
	echo "Cron exist";
fi

if [ $CDATA -eq 0 ]; then
	(crontab -l 2>/dev/null; echo "*/5 * * * * /usr/local/bin/read_data.sh") | crontab -
else
	echo "Cron exist";
fi


echo "Systemd"
cp -rf DATA_v2/oledpy.service /etc/systemd/system/
systemctl enable oledpy.service
systemctl start oledpy.service


echo "Pripravuj system"
echo "g_serial" > /etc/modules
echo "w1-therm" >> /etc/modules
echo "w1-gpio" >>  /etc/modules


echo "Pripravuji boot"
BW1=`cat /boot/armbianEnv.txt | grep param_w1_pin | wc -l`
if [ $BW1 -eq 0 ]; then
	echo "param_w1_pin=PA14" >> /boot/armbianEnv.txt
	echo "param_w1_pin_int_pullup=1" >> /boot/armbianEnv.txt
	awk '{if ($1 ~ /^overlays=/) print $0, "w1-gpio i2c0"; else print $0}' /boot/armbianEnv.txt > /tmp/a.txt | mv /tmp/a.txt /boot/armbianEnv.txt
else
	echo "Boot byl pripraven";
fi

reboot
