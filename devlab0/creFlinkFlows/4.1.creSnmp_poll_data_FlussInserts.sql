SET 'parallelism.default'    = '2';
SET 'sql-client.verbose'     = 'true';
SET 'execution.runtime-mode' = 'streaming';


SET 'pipeline.name' = 'Push SNMP snmp_poll_data1 => fluss.snmp_poll_data';

INSERT INTO fluss.snmp.snmp_poll_data
    (device_id, metric_oid, metric_value, data_type, instance_identifier, ts, partition_month)
SELECT
     device_id                                      AS device_id
    ,metric_oid                                     AS metric_oid      
    ,metric_value                                   AS metric_value
    ,data_type                                      AS data_type
    ,instance_identifier                            AS instance_identifier
    ,CAST(ts AS STRING)                             AS ts -- Cast the TIMESTAMP(3) to STRING for the target table
    ,DATE_FORMAT(ts, 'yyyyMM')                      AS partition_month -- Directly format the TIMESTAMP column
FROM hive.snmp.snmp_poll_data1;


SET 'pipeline.name' = 'Push SNMP snmp_poll_data2 => fluss.snmp_poll_data';

INSERT INTO fluss.snmp.snmp_poll_data
    (device_id, metric_oid, metric_value, data_type, instance_identifier, ts, partition_month)
SELECT
     device_id                                      AS device_id
    ,metric_oid                                     AS metric_oid      
    ,metric_value                                   AS metric_value
    ,data_type                                      AS data_type
    ,instance_identifier                            AS instance_identifier
    ,CAST(ts AS STRING)                             AS ts -- Cast the TIMESTAMP(3) to STRING for the target table
    ,DATE_FORMAT(ts, 'yyyyMM')                      AS partition_month -- Directly format the TIMESTAMP column
FROM hive.snmp.snmp_poll_data2;


SET 'pipeline.name' = 'Push SNMP snmp_poll_data3 => fluss.snmp_poll_data';

INSERT INTO fluss.snmp.snmp_poll_data
    (device_id, metric_oid, metric_value, data_type, instance_identifier, ts, partition_month)
SELECT
     device_id                                      AS device_id
    ,metric_oid                                     AS metric_oid      
    ,metric_value                                   AS metric_value
    ,data_type                                      AS data_type
    ,instance_identifier                            AS instance_identifier
    ,CAST(ts AS STRING)                             AS ts -- Cast the TIMESTAMP(3) to STRING for the target table
    ,DATE_FORMAT(ts, 'yyyyMM')                      AS partition_month -- Directly format the TIMESTAMP column
FROM hive.snmp.snmp_poll_data3;