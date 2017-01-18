FROM java:8-jre-alpine

ENV SPARK_VERSION=2.0.2-bin-hadoop2.7
ENV SPARK_HOME=/opt/spark-$SPARK_VERSION

RUN apk add --no-cache bash \
  && wget -O spark.tgz http://d3kbcqa49mib13.cloudfront.net/spark-$SPARK_VERSION.tgz \
  && mkdir /opt \
  && tar -C /opt -xf spark.tgz \
  && rm spark.tgz \
  && pip3 install --upgrade pip \
  && pip3 install -e $SPARK_HOME/python/.

COPY spark-docker.sh /bin/
COPY spark-env.sh $SPARK_HOME/conf/spark-env.sh

CMD spark-docker.sh
