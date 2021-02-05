from pyA20.gpio import gpio
from pyA20.gpio import port

import dht
import time
import datetime

# initialize GPIO
PIN2 = port.PA7
gpio.init()
state = gpio.input(PIN2)
state = str(state)

dht=open("/var/www/html/dht.txt","w")
dht.write(state)
dht.close()


