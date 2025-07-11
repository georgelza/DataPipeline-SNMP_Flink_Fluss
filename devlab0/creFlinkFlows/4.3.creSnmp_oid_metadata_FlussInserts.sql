SET 'parallelism.default'    = '2';
SET 'sql-client.verbose'     = 'true';
SET 'execution.runtime-mode' = 'streaming';


SET 'pipeline.name' = 'Push SNMP snmp_oid_metadata_pg => fluss.snmp_oid_metadata';

INSERT INTO fluss.snmp.snmp_oid_metadata
    (oid_string, object_name, data_type, info, oid_type, mib_module)
SELECT
     oid_string                         AS oid_string      
    ,object_name                        AS object_name           
    ,data_type                          AS data_type   
    ,info                               AS info        
    ,oid_type                           AS oid_type              
    ,mib_module                         AS mib_module      
FROM hive.snmp.snmp_oid_metadata_pg;


SET 'pipeline.name' = 'Push SNMP snmp_oid_metadata_mysql => fluss.snmp_oid_metadata';

INSERT INTO fluss.snmp.snmp_oid_metadata
    (oid_string, object_name, data_type, info, oid_type, mib_module)
SELECT
     oid_string                         AS oid_string      
    ,object_name                        AS object_name           
    ,data_type                          AS data_type   
    ,info                               AS info        
    ,oid_type                           AS oid_type              
    ,mib_module                         AS mib_module      
FROM hive.snmp.snmp_oid_metadata_mysql;


#SET 'pipeline.name' = 'Push SNMP snmp_oid_metadata_redis => fluss.snmp_oid_metadata';

-- INSERT INTO fluss.snmp.snmp_oid_metadata
--     (oid_string, object_name, data_type, info, oid_type, mib_module)
-- SELECT
--      oid_string                         AS oid_string      
--     ,object_name                        AS object_name           
--     ,data_type                          AS data_type   
--     ,info                               AS info        
--     ,oid_type                           AS oid_type              
--     ,mib_module                         AS mib_module      
-- FROM hive.snmp.snmp_oid_metadata_redis;