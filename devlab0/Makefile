
.DEFAULT_GOAL := help
include .env

define HELP

Available commands:

- buildapp: Just build the docker app image.

- run: 			This will call core.

- deploy: 		This will create all the catalogs, databases. Flink/Fluss tables and Flink insert jobs.
- createcat:
- source:
- targets:
- inserts:
- lakehouse:

- stop: 		Stop the project.
- start: 		Start a stopped project.
- down: 		Tear down the project, clean directories.
- ps: 			Show all running containers.

- logs: 		Show/tail logs.
- logsf: 		Stream logs.
- watch: 		Watch logs.

- fsql: 		Open Flink Jobmanager and start sql-client.
- jm: 			Open a bash terminal inside Jobmanager.

endef

export HELP
help:
	@echo "$$HELP"
.PHONY: help


#	docker rmi $(docker images -q --filter "dangling=true")

run: 
	docker compose -p pipeline up -d \
		postgres metastore hiveserver2 \
		jobmanager taskmanager \
		zookeeper coordinator-server tablet-server-0 tablet-server-1 tablet-server-2 \
		 --remove-orphans 

#		namenode resourcemanager historyserver nodemanager1 datanode1 datanode2 datanode3 datanode4 datanode5 \
 
deploy:  createcat source  
# targets inserts
 
createcat:
	docker compose exec jobmanager /opt/flink/bin/sql-client.sh -f /sql/1.0.creCat.sql

source:
	docker compose exec jobmanager /opt/flink/bin/sql-client.sh -f /sql/2.1.snmp_poll_data_get.sql
	docker compose exec jobmanager /opt/flink/bin/sql-client.sh -f /sql/2.1.snmp_poll_data_walk.sql
#	docker compose exec jobmanager /opt/flink/bin/sql-client.sh -f /sql/2.1.snmp_poll_data_auth.sql

targets:
	docker compose exec jobmanager /opt/flink/bin/sql-client.sh -f /sql/3.1.creFlussTargets.sql

inserts:
	docker compose exec jobmanager /opt/flink/bin/sql-client.sh -f /sql/3.2.creFlussInserts.sql

lakehouse:
	docker compose exec jobmanager \
		/opt/flink/bin/flink run \
		/opt/flink/opt/fluss-flink-tiering-0.7.0.jar \
		--fluss.bootstrap.servers coordinator-server:9123 \
		--datalake.format paimon \
		--datalake.paimon.metastore filesystem \
		--datalake.paimon.warehouse /tmp/paimon

stop:
	docker compose stop

start:
	docker compose start

down:	
	docker compose down
	cd data/; rm -rf flink
	cd data/; rm -rf fluss
	cd data/; rm -rf paimon
	cd data/; rm -rf postgres

ps:
	docker compose ps

logs:
	docker compose logs

logsf:
	docker compose logs -f

watch:
	watch docker compose ps

fsql:
	docker compose exec jobmanager /opt/flink/bin/sql-client.sh

jm:
	docker compose exec jobmanager /bin/bash