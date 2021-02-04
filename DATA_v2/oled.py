#!/usr/bin/env python
# coding=utf-8

# Bibliotheken importieren
from lib_oled96 import ssd1306
from smbus import SMBus
import time
from pyA20.gpio import gpio
from pyA20.gpio import port
sleeping = 10 

from PIL import ImageFont, ImageDraw, Image
font = ImageFont.load_default()
i2cbus = SMBus(0)            # 0 = Raspberry Pi 1, 1 = Raspberry Pi > 1
oled = ssd1306(i2cbus)
font = ImageFont.load_default()
#font = ImageFont.truetype('/root/lib_oled96/FreeSerif.ttf', 12)
font = ImageFont.truetype('/root/orangepi/SSD1306/Varianta_1/C&C Red Alert [INET].ttf', 12)

draw = oled.canvas



while True:
        oled.cls()
        oled.display()

        #Kontrola cidel
        bmed = open("/var/www/html/bme.txt")
        bme = int(bmed.readline())
        dhtd = open("/var/www/html/dht.txt")
        dht = int(dhtd.readline())
        dsd = open("/var/www/html/ds.txt")
        ds = int(dsd.readline())

        # System info
        hostnamed = open("/etc/hostname")
        hostname = hostnamed.readline()
        ipwland = open("/var/www/html/wlan0.txt")
        ipwlan = ipwland.readline()
        ipethd = open("/var/www/html/eth0.txt")
        ipeth = ipethd.readline()

        draw.text((0, 0), "Name :", font=font, fill=1)
        draw.text((35, 0), hostname, font=font, fill=1)
        draw.text((0, 16), "WLAN:", font=font, fill=1)
        draw.text((30, 16), ipwlan, font=font, fill=1)
        draw.text((0, 32), "ETH :", font=font, fill=1)
        draw.text((30, 32), ipeth, font=font, fill=1)

        oled.display()
        time.sleep(sleeping)


        if ds == 1:
            oled.cls()
            oled.display()
            dstmpd = open("/var/www/html/dstmp.txt")
            dstmp = dstmpd.readline() 
            draw.text((0, 0), "TMP DS :", font=font, fill=1)
            draw.text((50, 0), dstmp, font=font, fill=1)
            oled.display()
            time.sleep(sleeping)

        if dht == 1:     
            oled.cls()
            oled.display()
            dhttmpd = open("/var/www/html/dhttmp.txt")
            dhttmp = dhttmpd.readline() 
            dhthumd = open("/var/www/html/dhthum.txt")
            dhthum = dhthumd.readline()
            dhtrbd = open("/var/www/html/dhtrb.txt")
            dhtrb = dhtrbd.readline()
            draw.text((0, 0), "DHT11", font=font, fill=1)
            draw.text((35, 0), "", font=font, fill=1)
            draw.text((0, 16), "TMP:", font=font, fill=1)
            draw.text((30, 16), dhttmp, font=font, fill=1)
            draw.text((0, 32), "HUM :", font=font, fill=1)
            draw.text((30, 32), dhthum, font=font, fill=1)
            draw.text((0, 48), "RB :", font=font, fill=1)
            draw.text((30, 48), dhtrb, font=font, fill=1)
            oled.display()
            time.sleep(sleeping)
        
        if bme == 1:
            oled.cls()
            oled.display()
            bmetmpd = open("/var/www/html/bmetmp.txt")
            bmetmp = bmetmpd.readline()
            bmehumd = open("/var/www/html/bmehum.txt")
            bmehum = bmehumd.readline()
            bmerbd = open("/var/www/html/bmerb.txt")
            bmerb = bmerbd.readline()
            bmepressd = open("/var/www/html/bmepress.txt")
            bmepress = bmepressd.readline()
            draw.text((0, 0), "BME :", font=font, fill=1)
            draw.text((35, 0), bmepress, font=font, fill=1)
            draw.text((0, 16), "TMP:", font=font, fill=1)
            draw.text((30, 16), bmetmp, font=font, fill=1)
            draw.text((0, 32), "HUM :", font=font, fill=1)
            draw.text((30, 32), bmehum, font=font, fill=1)
            draw.text((0, 48), "RB :", font=font, fill=1)
            draw.text((30, 48), bmerb, font=font, fill=1)
            oled.display()
            time.sleep(sleeping)
