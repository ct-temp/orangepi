#!/bin/bash

echo "Instaluji balíčky do systému"
apt-get -y install python3-distutils python3-dev i2c-tools libi2c-dev libjpeg-dev libjpeg-tools libfreetype-dev python3-pip python3-smbus rrdtool lighttpd chrony

echo "Instaluji GPIo pro Zero"
cd ~
git clone https://github.com/nvl1109/orangepi_zero_gpio.git
cd orangepi_zero_gpio
python3 setup.py install

echo "Instaluji balíčky do Pythonu"
pip3 install virtualenv Pillow smbus2 psutil setuptools

echo "Kopíruji data"
cp DATA_v2/*.py /usr/local/bin/
cp DATA_v2/*.sh /usr/local/bin/
cp RRD_v2/* /usr/local/bin/

echo "Nastavuji oprávnění"
chmod 755 /usr/local/bin/*.sh

echo "tmpfs /var/www/html tmpfs defaults,size=20m 0 0" >> /etc/fstab

echo "Systemd"
cp DATA_v2/oledpy.service /etc/systemd/system/
systemctl enable oledpy.service
systemctl start oledpy.service


echo "Pripravuj system"
echo "modprobe w1-therm" >> /etc/modules-load.d/modules.conf
echo "modprobe w1-gpio" >> /etc/modules-load.d/modules.conf
echo "param_w1_pin=PA14" >> /boot/armbianEnv.txt
echo "param_w1_pin_int_pullup=1" >> /boot/armbianEnv.txt
awk '{if ($1 ~ /^overlays=/) print $0, " w1-gpio"; else print $0}' /boot/armbianEnv.txt
reboot
