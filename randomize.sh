#!/bin/bash

set -ex

rm tmp || true
for i in `cat videos.txt`; do
  echo "$RANDOM $i" >> tmp
done 
cat tmp | sort | awk '{print $2}' > videos_random.txt
rm tmp || true

echo "SUCCESS: check videos_random.txt"
