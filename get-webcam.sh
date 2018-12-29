#!/bin/bash

url=$1
name=$2

date=`date +"%Y%m%d-%H%M"`
year=`date +"%Y"`
month=`date +"%m"`
day=`date +"%d"`

filename="/home/jm/dev/webcams/cameras/$name/$year/$month/$day/$date-$name.jpg"

if [ ! -d /home/jm/dev/webcams/cameras/$name/$year/$month/$day/ ]
then
   mkdir -p /home/jm/dev/webcams/cameras/$name/$year/$month/$day/
fi

wget $url -O $filename

