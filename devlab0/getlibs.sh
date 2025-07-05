#!/bin/bash

export curhome=$(pwd)
echo $curhome

# https://alibaba.github.io/fluss-docs/downloads/#fluss-060

## Pre included in the Fluss/Demo images.

cd $curhome
echo "--> Install JARs for Flink's: Fluss connector" 
mkdir -p $curhome/conf/flink/lib/fluss
cd $curhome/conf/flink/lib/fluss
wget https://repo1.maven.org/maven2/com/alibaba/fluss/fluss-flink-1.20/0.7.0/fluss-flink-1.20-0.7.0.jar
wget https://repo1.maven.org/maven2/com/alibaba/fluss/fluss-fs-hadoop/0.7.0/fluss-fs-hadoop-0.7.0.jar
wget https://repo1.maven.org/maven2/com/alibaba/fluss/fluss-lake-paimon/0.7.0/fluss-lake-paimon-0.7.0.jar
wget https://repo1.maven.org/maven2/org/apache/paimon/paimon-flink-1.20/1.0.1/paimon-flink-1.20-1.0.1.jar


cd $curhome
echo "--> Install JARs for Flink's: Fluss Tier Libraries" 
mkdir -p $curhome/conf/flink/opt
cd $curhome/conf/flink/opt
wget https://repo1.maven.org/maven2/com/alibaba/fluss/fluss-flink-tiering/0.7.0/fluss-flink-tiering-0.7.0.jar


cd $curhome
echo "--> Install JARs for Flink's: Fluss connector" 
mkdir -p $curhome/conf/flink/lib
cd $curhome/conf/flink/lib/flink
wget https://repo.maven.apache.org/maven2/org/apache/flink/flink-sql-json/1.20.1/flink-sql-json-1.20.1.jar


cd $curhome
echo "--> Install JARs for Flink's: Fluss connector" 
mkdir -p $curhome/conf/fluss/lib
cd $curhome/conf/fluss/lib
#wget https://repo1.maven.org/maven2/org/apache/flink/flink-shaded-hadoop-2-uber/2.8.3-10.0/flink-shaded-hadoop-2-uber-2.8.3-10.0.jar

cd $curhome
echo "--> Install JARs for Flink's: Hive Metastore connector specific (Catalogs)" 
mkdir -p $curhome/conf/flink/lib/hive
cd $curhome/conf/flink/lib/hive
wget https://repo1.maven.org/maven2/org/apache/flink/flink-sql-connector-hive-3.1.3_2.12/1.20.1/flink-sql-connector-hive-3.1.3_2.12-1.20.1.jar
wget https://repo.maven.apache.org/maven2/org/apache/hive/hive-exec/3.1.3/hive-exec-3.1.3.jar 
wget https://repo.maven.apache.org/maven2/org/apache/hive/hive-metastore/3.1.3/hive-metastore-3.1.3.jar
wget https://repo1.maven.org/maven2/org/apache/flink/flink-shaded-hadoop-2-uber/2.8.3-10.0/flink-shaded-hadoop-2-uber-2.8.3-10.0.jar

cd $curhome
