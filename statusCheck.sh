#!/bin/bash

#monitoring the free space

FU=$(df -H | egrep -v "Filesystem|tmpfs" | awk '{print $5}' | tr -d %)
TO="example@gmail.com"

if [[ $FU -ge 80 ]]
then 
	echo "Warning disk space is low - $FU" | mail -s "Disk Space alert !"$TO
else
	echo "You are all good to go"
fi	
