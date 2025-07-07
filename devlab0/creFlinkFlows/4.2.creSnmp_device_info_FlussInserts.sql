SET 'parallelism.default'    = '2';
SET 'sql-client.verbose'     = 'true';
SET 'execution.runtime-mode' = 'streaming';

SET 'pipeline.name' = 'Push SNMP snmp_device_info_mysql => fluss.snmp_device_info';

INSERT INTO fluss.snmp.snmp_device_info
    (device_id, ip_address, hostname, device_location, device_type, vendor, devmodel, firmware_version, last_updated_ts)
SELECT
     device_id                                      AS device_id
    ,ip_address                                     AS ip_address      
    ,hostname                                       AS hostname
    ,device_location                                AS device_location
    ,device_type                                    AS device_type
    ,vendor                                         AS vendor
    ,devmodel                                       AS devmodel
    ,firmware_version                               AS firmware_version
    ,last_updated_ts                                AS last_updated_ts
FROM hive.snmp.snmp_device_info_mysql;


SET 'pipeline.name' = 'Push SNMP snmp_device_info_pg => fluss.snmp_device_info';

INSERT INTO fluss.snmp.snmp_device_info
    (device_id, ip_address, hostname, device_location, device_type, vendor, devmodel, firmware_version, last_updated_ts)
SELECT
     device_id                                      AS device_id
    ,ip_address                                     AS ip_address      
    ,hostname                                       AS hostname
    ,device_location                                AS device_location
    ,device_type                                    AS device_type
    ,vendor                                         AS vendor
    ,devmodel                                       AS devmodel
    ,firmware_version                               AS firmware_version
    ,last_updated_ts                                AS last_updated_ts
FROM hive.snmp.snmp_device_info_pg;


SET 'pipeline.name' = 'Push SNMP snmp_device_info_redis => fluss.snmp_device_info';

INSERT INTO fluss.snmp.snmp_device_info
    (device_id, ip_address, hostname, device_location, device_type, vendor, devmodel, firmware_version, last_updated_ts)
SELECT
     device_id                                      AS device_id
    ,ip_address                                     AS ip_address      
    ,hostname                                       AS hostname
    ,device_location                                AS device_location
    ,device_type                                    AS device_type
    ,vendor                                         AS vendor
    ,devmodel                                       AS devmodel
    ,firmware_version                               AS firmware_version
    ,last_updated_ts                                AS last_updated_ts
FROM hive.snmp.snmp_device_info_redis;