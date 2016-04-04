#!/bin/bash
path=$1
file=$(basename $path)
cd /usr/local/spark/bin/
if aws s3 cp $1 $file ; then
chmod +x $file

JARS="/usr/local/spark/lib/spark-streaming-kinesis-asl.jar"
for bindir in /usr/local/bin/rtm-rules/lib/*; do
        JARS=$JARS,${bindir}
done
echo $JARS


docker-run-spark-env.sh $SPARK_HOME/bin/spark-submit \
--master local[*] \
--driver-memory $DRIVER_MEMORY \
--driver-class-path $SPARK_DRIVER_CLASSPATH \
--jars $JARS \
$file $ARGS 2>&1

else
  send "File $1 not found" "255"
fi

