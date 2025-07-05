
-- the following commands are executed using the Flink sql-client, this can be executed by running `make fsql` from inside <root>/devlab folder

USE CATALOG default_catalog;

CREATE CATALOG hive WITH (
  'type'          = 'hive',
  'hive-conf-dir' = './conf/'
);

USE CATALOG hive;

create database hive.snmp;

show databases;

USE CATALOG default_catalog;

CREATE CATALOG fluss WITH (
    'type'              = 'fluss',
    'bootstrap.servers' = 'coordinator-server:9123'
);

USE CATALOG fluss;
create database snmp;

show databases;
