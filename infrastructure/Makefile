.DEFAULT_GOAL := help

define HELP

Available commands:

- pullall: Pull all source images.

- pullsource: Pull source tar files.

- buildall: Build all images.

endef

export HELP
help:
	@echo "$$HELP"
.PHONY: help

pullall:  os flink fluss db misc 

pullsource: common hive  

buildall: buildos buildopenjdk11 buildhdfs buildopenjdk8 buildhive buildflinkbase buildflussbase builddb


# Base images used along the way, used to build 2nd level images.
# arm64/v8 used as base for all images except the app/*.
os: 
	docker pull arm64v8/ubuntu:24.04

	
flink:
	docker pull flink:1.20.1-scala_2.12-java17
	
fluss:
	docker pull fluss/fluss:0.7.0
	docker pull zookeeper:3.9.2

db:
	docker pull postgres:12	
	docker pull mysql:8.4	
	docker pull redis:8.0-bookworm

misc:
	docker pull python:3.13-bookworm

common:
	cd build-hdfs-openjdk11/base; mkdir stage; cd stage; wget https://downloads.apache.org/hadoop/common/hadoop-3.3.5/hadoop-3.3.5-aarch64.tar.gz
	cd build-hdfs-openjdk8/basehadooop; mkdir stage; cd stage; wget https://downloads.apache.org/hadoop/common/hadoop-3.3.5/hadoop-3.3.5-aarch64.tar.gz

hive:
# hive 3.1.3 is located in the Archive section now, to go on top of Hadoop 3.3.5
	cd build-hive-openjdk8/basehive; cd stage; wget https://archive.apache.org/dist/hive/hive-3.1.3/apache-hive-3.1.3-bin.tar.gz
	cd build-hive-openjdk8/basehive; cd stage; wget http://www.congiu.net/hive-json-serde/1.3.8/cdh5/json-serde-1.3.8-jar-with-dependencies.jar 
	cd build-hive-openjdk8/basehive; cd stage; wget https://jdbc.postgresql.org/download/postgresql-42.7.4.jar

###### Build Section ######

# Build a base Ubuntu 20.04 OS
buildos:
	cd ./build-ubuntu-os-24.04; make build

# Extend Ubuntu 20.04 OS + OpenJDK 11
buildopenjdk11:
	cd build-ubuntu-os-openjdk11; make build

# Now add Hadoop onto the Ubuntu 20.04 / openjdk11 base
buildhdfs:
	cd build-hdfs-openjdk11; make buildhadoopbase
	cd build-hdfs-openjdk11; make buildhdfsbase

# Extend Ubuntu 20.04 OS + OpenJDK 8
buildopenjdk8:
	cd ./build-ubuntu-os-openjdk8; make build

# Now add Hadoop onto the Ubuntu 20.04 / openjdk8 base followed by Hive 3.3.4
buildhive:
	cd build-hive-openjdk8; make buildhadoopbase
	cd build-hive-openjdk8; make buildbasehive

# Base images with some add on's - Flink 1.20.1 - Java 17
buildflinkbase:
	cd build-flink-base-1.20.1; make build

# Base images with some add on's - Add Missing jar's to base image
buildflussbase:
	cd build-fluss-base-0.7.0; make build

builddb:
	cd build-postgres-12.0; make build