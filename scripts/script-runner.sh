#!/bin/bash
path=$1
file=$(basename $path)
cd usr/local/spark/bin/
if aws s3 cp $1 $file ; then
chmod +x $file
docker-run-spark-env.sh $file 2>&1

else
  send "File $1 not found" "255"
fi

