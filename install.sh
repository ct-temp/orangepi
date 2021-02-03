#!/bin/bash

apt-get -y install python3-distutils python3-dev i2c-tools libi2c-dev libjpeg-dev libjpeg-tools libfreetype-dev python3-pip python3-smbus rrdtool lighttpd chrony

cp DATA_v2/* /usr/local/bin/
