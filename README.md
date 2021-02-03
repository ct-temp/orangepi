OrangePi


Instalace :

# APT
apt-get install python3-distutils python3-dev i2c-tools libi2c-dev libjpeg-dev libjpeg-tools libfreetype-dev python3-pip python3-smbus rrdtool lighttpd chrony

# PIP3
pip3 install virtualenv Pillow smbus2 psutil setuptools

# fstab
tmpfs /var/www/html    tmpfs    defaults,size=20m    0    0

# Crontab
*/5 *  * * * root /usr/local/bin/read_data.sh

59 * * * * root /usr/local/bin/sync_data.sh

### Čas
- v /etc/chrony/chrony.conf

###### zaremovat
- #pool ntp.ubuntu.com        iburst maxsources 4
- #pool 0.ubuntu.pool.ntp.org iburst maxsources 1
- #pool 1.ubuntu.pool.ntp.org iburst maxsources 1
- pool 2.ubuntu.pool.ntp.org iburst maxsources 2

###### vložit
- server 172.30.29.187
- server 172.30.29.98
