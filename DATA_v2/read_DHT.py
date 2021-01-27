from pyA20.gpio import gpio
from pyA20.gpio import port


import dht
import time
import datetime

# initialize GPIO
PIN2 = port.PA6
gpio.init()

# read data using pin
instance = dht.DHT(pin=PIN2)

result = instance.read()
dhttmp  = open("/var/www/html/dhttmp.txt","w")
teplota = str(result.temperature); 
dhttmp.write(teplota)
dhttmp.close()

dhthum  = open("/var/www/html/dhthum.txt","w")
humidity = str(result.humidity); 
dhthum.write(humidity)
dhthum.close()

