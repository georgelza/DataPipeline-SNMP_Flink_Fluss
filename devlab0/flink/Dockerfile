ARG REPO_NAME="georgelza"

FROM ${REPO_NAME}/apacheflink-base-1.20.1-scala_2.12-java17:1.0.0
SHELL ["/bin/bash", "-c"]

ENV FLINK_HOME=/opt/flink
ENV HIVE_HOME=$FLINK_HOME/conf/

# this is where we have flink itself installed.
WORKDIR $FLINK_HOME

RUN echo "--> Setup Directory Structure" && \
    mkdir -p /opt/flink/conf/ && \
    mkdir -p /opt/flink/checkpoints && \
    mkdir -p /opt/flink/rocksdb && \
    mkdir -p /opt/sql-client/conf/

RUN echo "--> Install JARs: Flink's S3 plugin" && \
    mkdir -p ./plugins/s3-fs-hadoop && \
    mv ./opt/flink-s3-fs-hadoop-1.20.1.jar ./plugins/s3-fs-hadoop/

# Remove any other default log4j properties files that might conflict
# This ensures that ONLY your log4j.properties is considered by Flink's logging system.
# RUN rm -f $HIVE_HOME/log4j-session.properties \
#           $HIVE_HOME/log4j-console.properties

# COPY log4j.properties $HIVE_HOME/log4j.properties

# /usr/local/lib/python3.10/dist-packages/jupyterlab
# Install JARs
# See https://repo.maven.apache.org/maven2/org/apache/flink/

RUN echo "--> Set Ownerships of /opt/flink and /opt/sql-client" && \
    chown -R flink:flink $FLINK_HOME && \
    chown -R flink:flink /opt/sql-client

CMD ./bin/start-cluster.sh && sleep infinity

USER flink:flink
