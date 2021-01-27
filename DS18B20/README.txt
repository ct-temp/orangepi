# do /boot/armbianEnv.txt
overlays=i2c0 i2c1 i2c2 usbhost2 usbhost3 w1-gpio
param_w1_pin=PA14
param_w1_pin_int_pullup=1

# do /etc/modules-load.d/modules.conf
modprobe w1-therm
modprobe w1-gpio


# cidlo je v ceste :
# 28-xxx se meni podle adresy cidla
cat /sys/bus/w1/devices/28-0115c1b239ff/w1_slave
