#!/bin/bash
path=$1
file=$(basename $path)
cd /usr/local/spark/bin/
if aws s3 cp $1 $file ; then
chmod +x $file

docker-run-spark-env.sh /usr/local/spark/bin/spark-submit --driver-memory $DRIVER_MEMORY \
--driver-class-path "/usr/local/spark/lib/mysql-connector-java.jar" \
--jars "/usr/local/spark/lib/spark-avro.jar,/usr/local/spark/lib/spark-redshift.jar,/usr/local/spark/lib/spark-csv_2.11-1.3.0.jar,/usr/local/spark/lib/commons-csv-1.2.jar,/usr/local/spark/lib/RedshiftJDBC41-1.1.10.1010.jar,/usr/local/spark/lib/spark-streaming-kinesis-asl.jar" \
$file $ARGS $DRIVER_MEMORY 2>&1

else
  send "File $1 not found" "255"
fi

