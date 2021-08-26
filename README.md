![example workflow](https://github.com/dalmatialab/spark/actions/workflows/main.yml/badge.svg)


# Supported tags and respective Dockerfile links

 - 2.4.8-rc-1

# What is Spark ? 

[Apache Spark](https://spark.apache.org/) is a unified analytics engine for large-scale data processing. It provides high-level APIs in Java, Scala, Python and R, and an optimized engine that supports general execution graphs. It also supports a rich set of higher-level tools including Spark SQL for SQL and structured data processing, MLlib for machine learning, GraphX for graph processing, and Structured Streaming for incremental computation and stream processing.

<img src="https://github.com/dalmatialab/spark/blob/434ca7a3bccd6be7396d0b76a417138c8eed0b18/logo.png?raw=true" width="200" height="150">

# How to use this image

## Start Spark master instance

	$ docker run -d --name some-spark-master -e TYPE=master -p 8080:8080 image:tag

Where:

 - `some-spark-master` is name you want to assign to your container
 - `image` is Docker image name
 - `tag` is Docker image version

## Start Spark worker instance

	$ docker run -d --name some-spark-worker -e TYPE=worker -e SPARK_MASTER=spark://spark-master:7077 image:tag

Where:

 - `some-spark-worker` is name you want to assign to your container
 - `spark-master` is spark master endpoint at which worker is connecting
 - `image` is Docker image name
 - `tag` is Docker image version

## Environment variables

**TYPE**

This is *required* variable. It specifies starting script target. Possible values are: master, worker.

**SPARK_MASTER**

This is *required* variable. It specifies Spark master endpoint at which worker will connect.

## Ports

Spark master exposes user interface at port 8080.

## NOTE

This image comes with support for Geomesa datastore querying and analitics.  

This image comes with python 3.5.9 and pyspark support to enable connection to master from python application code.  
If spark application requires new python packages it must be installed on all workers.  

Preinstalled python packages are: scipy, pandas, numpy, shapely, pyspark.

# License

