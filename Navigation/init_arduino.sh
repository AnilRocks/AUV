#!/bin/bash

Arduino=$(grep "arduino" < PATH | cut -d'"' -f2)
if ! [ -e $Arduino ]
then
	echo "Arduino not connected!"
	exit
fi
stty -F $Arduino 9600
cat $Arduino &
ARDUINO=$!
sleep 2.5
echo "Arduino-"$ARDUINO >> processes
echo "Arduino succesfully initialised!"

