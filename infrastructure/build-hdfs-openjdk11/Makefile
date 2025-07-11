.DEFAULT_GOAL := help
include ../.env

VERSION=1.0.0
HADOOP_VERSION=3.3.5-java11

define HELP

Based on Ubuntu 25.04 / OpenJDK 11 / Apache Hadoop $(HADOOP_VERSION):$(VERSION)

Available commands:

- wget: Download Apache Hadoop $(HADOOP_VERSION) tar.gz source files.

- buildbase: Build the base image project

- build: Build this project

- run: Run the project

- stop: Stop the project

- down: Stop and remove the project

- logs: Show the logs

- ps: Show the status

endef

export HELP
help:
	@echo "$$HELP"
.PHONY: help

wget: clean
	cd base; mkdir -p stage
	cd base; cd stage; wget https://downloads.apache.org/hadoop/common/hadoop-3.3.5/hadoop-3.3.5-aarch64.tar.gz

clean:
	cd base; cd stage; rm *

buildbase:
	docker build --build-arg REPO_NAME=${REPO_NAME} -t ${REPO_NAME}/hadoop-base-$(HADOOP_VERSION):$(VERSION) ./base --no-cache

build: 
	docker build --build-arg REPO_NAME=${REPO_NAME} -t ${REPO_NAME}/hadoop-namenode-$(HADOOP_VERSION):$(VERSION) ./namenode
	docker build --build-arg REPO_NAME=${REPO_NAME} -t ${REPO_NAME}/hadoop-datanode-$(HADOOP_VERSION):$(VERSION) ./datanode
	docker build --build-arg REPO_NAME=${REPO_NAME} -t ${REPO_NAME}/hadoop-resourcemanager-$(HADOOP_VERSION):$(VERSION) ./resourcemanager
	docker build --build-arg REPO_NAME=${REPO_NAME} -t ${REPO_NAME}/hadoop-nodemanager-$(HADOOP_VERSION):$(VERSION) ./nodemanager
	docker build --build-arg REPO_NAME=${REPO_NAME} -t ${REPO_NAME}/hadoop-historyserver-$(HADOOP_VERSION):$(VERSION) ./historyserver

run:
	docker compose -p pipeline up -d

stop:
	docker compose stop

down:
	docker compose down

logs:
	docker compose logs

ps:
	docker compose ps