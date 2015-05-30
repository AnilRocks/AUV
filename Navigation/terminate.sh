#!/bin/bash

if ! [ -e "processes" ] ; then
	echo "All processes terminated successfully!"
else
if [ "$1" == "all" ] ; then
	kill $(cut -d'p' -f1 <(ps | grep -f <(cut -d'-' -f2 < processes)))
	rm processes
	if [ -e "tmp" ] ; then	
		rm tmp
	fi
	if [ -e "square" ] ; then
		rm square
	fi
	echo "All process terminated successfully!"
else
	kill $(cut -d'p' -f1 <(ps | grep -f <(grep "$1" < processes | cut -d'-' -f2)))
	sed -i /$1/d processes
	echo $1 "terminated!"
fi
fi
