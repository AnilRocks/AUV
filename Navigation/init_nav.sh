#!/bin/bash

NavStik=$(grep "navstik" < PATH | cut -d'"' -f2)
if ! [ -e $NavStik ]
then
	echo "NavStik not connected!"
	exit
fi
stty -F $NavStik 115200
echo "\r" > $NavStik
echo "\r" > $NavStik
echo "usb start" > $NavStik
if ! cat $NavStik | grep -q "NAVSTIK"
then
	echo "NavStik not initialised!"
else
	value='0'
	echo "Initializing NavStik...... Keep the IMU as stable as possible"
	while read line ; do
	if [[ $line =~ "NAVSTIK2" ]]; then
		init_value=$value;
		value="${line:29:7}" ;
		diff="$(bc <<< "scale=3; $init_value - $value")"
		diff="${diff//-}"
		#echo 'A' $diff
		[[ $(bc <<< "$diff < 0.001") -eq 1 ]] && i=$(($i+1)) || i=0
		[[ $i -gt 500 ]] && break
	fi
	done < $NavStik
echo "NavStik succesfully initialised!"
fi
