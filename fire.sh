#!/bin/bash


PIDF=/tmp/mp-fire.pid
if [ -f $PIDF ]; then
  ps ax | grep `cat $PIDF` && exit 1
fi
echo $$ > $PIDF

#PIN for number pin
PIN=18

#VOLTAGE for voltage selection(1 for Ground and 0 for 5V or 3V3)
VOLTAGE=1


#Export pin for workspace
echo "$PIN" > /sys/class/gpio/unexport
echo "$PIN" > /sys/class/gpio/export
echo "out" > /sys/class/gpio/gpio$PIN/direction
echo "$VOLTAGE" > /sys/class/gpio/gpio$PIN/value



#Check fire
while true; do


value=$(cat $"/sys/class/gpio/gpio$PIN/value")
if [ "$value" ==  "1" ]
then
        echo "All work"
	amixer -c1 set 'Headphone',0 unmute
else
        echo "Off"
	amixer -c1 set 'Headphone',0 mute
	fi
sleep 1
done
