#!/bin/bash

TIMEOUT=60
n=0

if [ ! -e "videos_random.txt" ]; then
  echo "ERROR: please randomize the videos with randomize.sh"
  exit 1
fi

vids=`cat videos_random.txt`
for vid in $vids; do
  echo "starting next vid=$n"
  open "$vid"

  echo "seconds until next vid: "
  for i in `seq 1 $TIMEOUT`; do 
    echo "... $((TIMEOUT-i))"
    sleep 1
  done

  killall "Google Chrome"
  sleep 1
  n=$((n+1))
done
