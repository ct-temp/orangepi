#!/bin/bash
CIDLO=28-0115c1b239ff


if [[ -f /sys/bus/w1/devices/$CIDLO/w1_slave ]];then
	cat /sys/bus/w1/devices/28-0115c1b239ff/w1_slave | grep "t=" | cut -d "=" -f 2
else
	echo "Nenasel jsem cidlo"
fi
