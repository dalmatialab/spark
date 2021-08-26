#!/bin/bash

if [ "$TYPE" = "master" ]; then

export SPARK_MASTER_HOST=`hostname`

. "${SPARK_HOME}/sbin/spark-config.sh"

. "${SPARK_HOME}/bin/load-spark-env.sh"

mkdir -p $SPARK_LOGS

ln -sf /dev/stdout $SPARK_MASTER_LOG/spark-master.out

cd ${SPARK_HOME}/bin && ${SPARK_HOME}/sbin/../bin/spark-class org.apache.spark.deploy.master.Master \
    --ip $SPARK_MASTER_HOST  >> $SPARK_LOGS/spark-master.out

elif [ "$TYPE" = "worker" ]; then

. "${SPARK_HOME}/sbin/spark-config.sh"

. "${SPARK_HOME}/bin/load-spark-env.sh"

mkdir -p $SPARK_LOGS

ln -sf /dev/stdout $SPARK_LOGS/spark-worker.out

${SPARK_HOME}/sbin/../bin/spark-class org.apache.spark.deploy.worker.Worker \
    $SPARK_MASTER >> $SPARK_LOGS/spark-worker.out

fi
