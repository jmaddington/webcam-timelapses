#!/bin/bash
rm ffmpeg.sh
cd cameras/
ls -d -l */ |sort|while read -r camdir
do
   camera=`echo ${camdir%?}|awk '{print $9}'`
   echo Camera is $camera

   sleep 1

   rm $camera.concat.txt
   find $camera/ -type f -name *.jpg | sort > $camera.concat.txt   

   rm $camera.input.txt
   cat $camera.concat.txt | while read -r frame
   do 
      echo file \'./$frame\'>>$camera.input.txt
      echo duration 0.1 >>$camera.input.txt
   done

echo /usr/bin/ffmpeg -y -f concat -safe 0 -i $camera.input.txt -vf fps=24 $camera.mp4 >> ffmpeg.sh

done

chmod 755 ffmpeg.sh
./ffmpeg.sh
cd ..
