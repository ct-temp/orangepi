#!/usr/bin/env python
# coding=utf-8

# Bibliotheken importieren
from lib_oled96 import ssd1306
from smbus import SMBus
import time
from pyA20.gpio import gpio
from pyA20.gpio import port


import dht
import time
import datetime

import sys
import numpy as np

a = 17.271
b = 237.7 # degC

#dstmp = open("/root/ramdisk/dstmp.txt","w")
#dhttmp = open("/root/ramdisk/dhttmp.txt","w")

# initialize GPIO
PIN2 = port.PG7                                                     #bylo zmeneno na PG7 kvuli chybe na schematu data cidla DHT
gpio.init()

# read data using pin
instance = dht.DHT(pin=PIN2)


from PIL import ImageFont, ImageDraw, Image



import socket

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
s.connect(('8.8.8.8', 1))  # connect() for UDP doesn't send packets
ip_address = s.getsockname()[0]


hostname = socket.gethostname()

temp_sensor = '/sys/devices/w1_bus_master1/28-000006dc20e4/w1_slave' #---------------sekce cteni DS18D20--------------------------
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
    temp_c = float(temp_string)/100.0                               #puvodne bylo /1000
    temp_c = int(temp_c)
    temp_c=temp_c/10;                                               #doplneny radek
    return temp_c


def dewpoint_approximation(T,RH):
    Td = (b * gamma(T,RH)) / (a - gamma(T,RH))
    return Td
 
 
def gamma(T,RH):
    g = (a * T / (b + T)) + np.log(RH/100.0)
    return g


                                                                    #---------------konec sekce cteni DS18D20--------------------------
font = ImageFont.load_default()
# Display einrichten
i2cbus = SMBus(0)            # 0 = Raspberry Pi 1, 1 = Raspberry Pi > 1
oled = ssd1306(i2cbus)

font = ImageFont.load_default()
font = ImageFont.truetype('/root/lib_oled96/FreeSerif.ttf', 14)
# Ein paar Abkürzungen, um den Code zu entschlacken
draw = oled.canvas

# Display zum Start löschen


while True:
    result = instance.read()
    if result.is_valid():
        oled.cls()
        oled.display()

                                                                   #-----------------------ctenu hodnot humidity DHT-------------------- 
        dhthum = open("/root/ramdisk/dhthum.txt","a")

        temp = (format(result.temperature))
        #puf = int(result.humidity)/10
        #hum = (format(puf))

        hum = (format(result.humidity))
                                                                   #-----------------------konec ctenu hodnot humidity DHT---------------


                                                                   #-----------------------zapis hodnot na displej-----------------------
        #teplota = read_temp();
        teplota = str(read_temp());
        draw.text((0, 0), "IP:", font=font, fill=1)                                      #IP adresas
        draw.text((20, 0), ip_address, font=font, fill=1)
        draw.text((0, 16), "DHT temp:", font=font, fill=1)
        draw.text((70, 16), temp, font=font, fill=1)
        draw.text((0, 32), "DHT hum:", font=font, fill=1)
        draw.text((70, 32), hum, font=font, fill=1)
        draw.text((0, 48), "DS temp:", font=font, fill=1)
        draw.text((70, 48), teplota, font=font, fill=1)
        oled.display()
        time.sleep(2)




                                                                   #-------------------------z8pis hodnt do RAM disku----------------------
        if not teplota:
            print('Neni teplota na DS')
        else:
            dstmp  = open("/root/ramdisk/dstmp.txt","w")
            dstmp.write(teplota)
            dstmp.close()
        

        if not temp:
            print('Neni teplota na DHT')
        else:
            dhttmp = open("/root/ramdisk/dhttmp.txt","w")
            dhttmp.write(temp)
            dhttmp.close()
            T=float(temp)

        if not dhthum:
            print('Neni vlhkost na DHT')
        else:
            dhthum = open("/root/ramdisk/dhthum.txt","w")
            dhthum.write(hum)
            dhthum.close()
            RH = float(hum)
    
        Td = dewpoint_approximation(T,RH)
        print ('T, RH',T,RH)
        print ('Td=',Td)
    time.sleep(2)
