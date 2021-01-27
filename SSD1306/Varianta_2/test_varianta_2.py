#!/usr/bin/env python
# coding=utf-8

# Bibliotheken importieren
from lib_oled96 import ssd1306
from smbus import SMBus
import time

import socket

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
s.connect(('8.8.8.8', 1))  # connect() for UDP doesn't send packets
ip_address = s.getsockname()[0]


hostname = socket.gethostname()

temp_sensor = '/sys/devices/w1_bus_master1/28-0115c1b239ff/w1_slave'
def temp_raw():
  f = open(temp_sensor,'r')
  lines = f.readlines()
  f.close()
  return lines

def read_temp():
  lines = temp_raw()
  while lines[0].strip()[-3:] != 'YES':
    time.sleep(0.2)
    lines = temp_raw()
  temp_output = lines[1].find('t=')
  if temp_output != -1:
    temp_string = lines[1][temp_output+2:]
    temp_c = float(temp_string)/1000.0
    temp_c = int(temp_c);
    return temp_c



# Display einrichten
i2cbus = SMBus(0)            # 0 = Raspberry Pi 1, 1 = Raspberry Pi > 1
oled = ssd1306(i2cbus)

# Ein paar Abkürzungen, um den Code zu entschlacken
draw = oled.canvas

# Display zum Start löschen

teplota = str(read_temp());

while True:
    oled.cls()
    oled.display()

    draw.text((20, 16), ip_address, fill=1)
    draw.text((40, 32), "Teplota", fill=1)
    draw.text((60, 50), teplota, fill=1)

    oled.display()

    time.sleep(10)


