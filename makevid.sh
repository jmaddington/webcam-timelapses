#!/bin/bash

cd cameras/
rm ffmpeg.sh

ls -d -l */ |sort|while read -r camdir
do

   date=`date +"%Y%m%d-%H%M"`
   camera=`echo ${camdir%?}|awk '{print $9}'`
   filename="$date-$camera.mp4"
   echo Camera is $camera, filename will be $filename

   sleep 1

   rm $camera.concat.txt
   #Size comparison in here to filter out bad jpegs
   find $camera/ -type f -name *.jpg -size +15k -cmin -525600 | sort > $camera.concat.txt   

   rm $camera.input.txt
   cat $camera.concat.txt | while read -r frame
   do 
      echo file \'./$frame\'>>$camera.input.txt
      echo duration 0.1 >>$camera.input.txt
   done

   echo /usr/bin/ffmpeg -y -f concat -safe 0 -i $camera.input.txt -vf fps=60 $filename >> ffmpeg.sh

done

chmod 755 ffmpeg.sh
./ffmpeg.sh
cd ..
