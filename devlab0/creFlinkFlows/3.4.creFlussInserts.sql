SET 'parallelism.default'    = '2';
SET 'sql-client.verbose'     = 'true';
SET 'execution.runtime-mode' = 'streaming';

SET 'pipeline.name' = 'Push SNMP snmp_device_info => fluss.snmp_device_info';

INSERT INTO fluss.snmp.snmp_device_info
    (device_id, metric_oid, metric_value, data_type, instance_identifier, ts, partition_month)
SELECT
     device_id                                      AS device_id
    ,metric_oid                                     AS metric_oid      
    ,metric_value                                   AS metric_value
    ,data_type                                      AS data_type
    ,instance_identifier                            AS instance_identifier
    ,ts                                             AS ts
    ,DATE_FORMAT(TO_TIMESTAMP_LTZ(ts, 3), 'yyyyMM') AS partition_month
FROM hive.snmp.snmp_device_info;


SET 'pipeline.name' = 'Push SNMP snmp_oid_mtadata => fluss.snmp_oid_mtadata';

INSERT INTO fluss.snmp.snmp_oid_mtadata
    (device_id, metric_oid, metric_value, data_type, instance_identifier, ts, partition_month)
SELECT
     device_id                                      AS device_id
    ,metric_oid                                     AS metric_oid      
    ,metric_value                                   AS metric_value
    ,data_type                                      AS data_type
    ,instance_identifier                            AS instance_identifier
    ,ts                                             AS ts
    ,DATE_FORMAT(TO_TIMESTAMP_LTZ(ts, 3), 'yyyyMM') AS partition_month
FROM hive.snmp.snmp_oid_mtadata;

