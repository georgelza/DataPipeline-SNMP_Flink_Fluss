## Environment configuration and deployment

See the master <root>/`README.md` file for the basic downloading of all the containers and library/jar files and building various containers images used and then see the "Run the stack" lower down.


### To test the stack see:  ->  Create Catalogs

To test the stack see:

It starts with creating base catalogs, we have 2, `hive` and `fluss`.

This `fluss` catalog is created inside Flink, referencing the fluss `bootstrap.servers` which creates the link between the Fluss and Flink environments.

[Manually testing stack](https://alibaba.github.io/fluss-docs/docs/engine-flink/getting-started/#preparation-when-using-flink-sql-client)

```json
CREATE CATALOG fluss WITH (
    'type'              = 'fluss',
    'bootstrap.servers' = 'coordinator-server:9123'
);
```


### Variables and Variables and Variables...

There is sadly no easy way to do this as this is not a small stack, of a single product.


- Start by going into `conf` directory and see the various files there.

- Followed by the `.env` file and then the docker-compose file.

- Also take note of the `configs` section in the `docker-compose.yml` file. These files are mapped into the various services.


### Flink configuration variables.

See the `docker-compose.yaml` file for the various variables passed into the Flink containers.

We use a combination of `environment:` values and values from files passed in via the `volumes:` section.

Some of them originate out of the `.env` file, for the Hive environment some originate out of the `hive.env` file and some out of `config.yaml`.

You will also find the logging parameter files are specified in the `configs` section and then mapped into the containers in the services.


### Hive site configuration file for Flink usage.

Take note that the flink images are build with `hive-site.xml`.


### PostgreSQL configuration, 

The credentials are sourced from the `.env` file and the start parameters out of `conf/postgresql.conf` & `conf/pg_hba.conf`.

NOTE: We're create 2 PostgreSQL servers, 
1.  postgresql      => used as the HMS
2.  postgresqlsnmp  => used as the snmp data store for the oid_metada and device_info tables.

## Run the stack

### Basic last setup steps.

1. cd ./devlab0/flink
   
2. make build
   
3. cd ./devlab0
   
4. `make run`

5. `make ps`            -> until all stable, give is 20-30 seconds.

6. `make deploy`        -> this will kick off a couple of scripts to create the flink catalogs and databases and various flink tables and jobs.

   1. `make source`     -> This will create our various Flink tables configured using the MQTT connector exposing the data via `hive_catalog.mqtt.<table_name>` table objects.

   2. `make targets`    -> This will create our Fluss `fluss.snmp.*` tables and our snmp output tables.
      
   3. `make inserts`    -> This will start the various inserts of data from our source table objects, into the `fluss.snmp.*` tables.
    
7.  `make lakehouse` -> This will start our lakehouse persisting job, which will move our `fluss.snmp` tables to the **Apache Paimon** based table located on our **HDFS** stack.


## External Tables

NOTE: remember to lin with external tables via JDBC or with a external store like REDIS you do need to add the required jar file to the devlab0/conf/flink/lib/flink which is then mounted onto the Jobmanager and Taskmanager's lib directory.

This becomes especially relevant if you want to access data pushed into snmp_device_info or snmp_oid_metadata tables.