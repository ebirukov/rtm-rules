#!/bin/bash
path=$1
file=$(basename $path)
spark_home=/usr/local/spark
cd $spark_home/bin/
if aws s3 cp $1 $file ; then
chmod +x $file

unzip -j $file -d $spark_home/lib
JARS=$SPARK_JARS 
for bindir in $spark_home/lib/*; do
        JARS=$JARS,${bindir}
done
echo $JARS


docker-run-spark-env.sh $SPARK_HOME/bin/spark-submit \
--master local[*] \
--driver-memory $DRIVER_MEMORY \
--driver-class-path $SPARK_DRIVER_CLASSPATH \
--jars $JARS \
--class com.drimmi.spark.KinesisStreamProcessor \
$spark_home/lib/rtm-rules.jar $ARGS 2>&1

else
  send "File $1 not found" "255"
fi

