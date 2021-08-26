FROM python:3.5.9-slim-stretch
LABEL maintainer="dalmatialab"

# Java installation
RUN mkdir /usr/share/man/man1/
RUN apt update && apt install -y openjdk-8-jre

# Tools installation
RUN apt update && apt install -y wget
RUN python -m pip install --upgrade pip

# Environment variables
ENV SPARK_VERSION=2.4.8
ENV HADOOP_SPARK_VERSION=2.7
ENV SCALA_GEOMESA_VERSION=2.11-3.1.0
ENV SPARK_HOME=/opt/spark
ENV SPARK_LOGS=/opt/spark/logs
ENV ACCUMULO_MAJOR_VERSION=2

# Adding on path
ENV PATH $JAVA_HOME/bin:$PATH
ENV PATH $SPARK_HOME/bin:$PATH

# Spark installatin
RUN mkdir -p /opt/spark/
RUN cd /opt/spark && wget https://downloads.apache.org/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_SPARK_VERSION}.tgz \
                  && tar -xvzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_SPARK_VERSION}.tgz --strip-components 1 \
                  && rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_SPARK_VERSION}.tgz
               
# Geomesa runtime
RUN cd /tmp && wget https://github.com/locationtech/geomesa/releases/download/geomesa_$SCALA_GEOMESA_VERSION/geomesa-accumulo_$SCALA_GEOMESA_VERSION-bin.tar.gz \
            && tar -xvzf geomesa-accumulo_$SCALA_GEOMESA_VERSION-bin.tar.gz \
            && cp geomesa-accumulo_${SCALA_GEOMESA_VERSION}/dist/spark/geomesa-accumulo-spark-runtime-accumulo${ACCUMULO_MAJOR_VERSION}_${SCALA_GEOMESA_VERSION}.jar ${SPARK_HOME}/jars \
            && rm -rf geomesa-accumulo_${SCALA_GEOMESA_VERSION} && rm geomesa-accumulo_${SCALA_GEOMESA_VERSION}-bin.tar.gz

ADD src/run.sh /run.sh
RUN chmod a+x /run.sh

RUN pip3 install scipy pandas numpy shapely pyspark

CMD ["/run.sh"]