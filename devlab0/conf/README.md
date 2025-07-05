## Configuration files.

Various confguratin files either push/mounted to a target file inside containers (utilising configs primitive) or pushed into environment variables inside containers.

1. flink                    -   Flink/lib jar files
                            -   Flink/opt Fluss required jar file

2. fluss                    -   Fluss/lib required jar files
   
3. config.yaml              -   Flink JobManager and TaskManager configuration settings, This file replaces flink-conf.yaml

4. Hadoop.env               -   Hadoop settings.

5. hive-site.xml            -   Minio settings for Hive to use.

6. hive.env                 -   Various Hive Metastore settings pulled into various configuration files.

7. log4j-*.properties       -   Log4J logging configuration files

8. pg_hba.conf              -   PostgreSql secrutity configuration.

9.  postgresql.conf          -   PostgreSql configuration file.


