#!/bin/bash

TIMEOUT=60
n=0

vids=`cat videos.txt`
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
