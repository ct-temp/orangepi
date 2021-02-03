#!/bin/bash

echo "Instaluji balíčky do systému"
apt-get -y install python3-distutils python3-dev i2c-tools libi2c-dev libjpeg-dev libjpeg-tools libfreetype-dev python3-pip python3-smbus rrdtool lighttpd chrony

echo "Instaluji balíčky do Pythonu"
pip3 install virtualenv Pillow smbus2 psutil setuptools

echo "Instaluji GPIo pro Zero"
cd ~
git clone https://github.com/nvl1109/orangepi_zero_gpio.git
cd orangepi_zero_gpio
python3 setup.py install

echo "Kopíruji data"
cp DATA_v2/* /usr/local/bin/

echo "Nastavuji oprávnění"
chmod 755 /usr/local/bin/*.sh
