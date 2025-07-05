
FROM fluss/fluss:0.7.0
SHELL ["/bin/bash", "-c"]

ENV FLUSS_HOME=/opt/flink

# this is where we have fluss itself installed.
WORKDIR /opt/fluss

RUN echo "--> Install JARs: Fluss HDFS jar"
COPY stage/flink-shaded-hadoop-2-uber-2.8.3-10.0.jar /opt/fluss/lib/flink-shaded-hadoop-2-uber-2.8.3-10.0.jar
COPY stage/fluss-fs-hadoop-0.7.0.jar /opt/fluss/lib/fluss-fs-hadoop-0.7.0.jar

RUN chown -R fluss:fluss /opt/fluss

USER fluss:fluss
