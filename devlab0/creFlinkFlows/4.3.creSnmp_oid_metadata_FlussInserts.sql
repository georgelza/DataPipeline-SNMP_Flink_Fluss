SET 'parallelism.default'    = '2';
SET 'sql-client.verbose'     = 'true';
SET 'execution.runtime-mode' = 'streaming';

SET 'pipeline.name' = 'Push SNMP snmp_oid_metadata_pg => fluss.snmp_oid_metadata';

INSERT INTO fluss.snmp.snmp_oid_metadata
    (oid_string, oid_name, description, syntax_type, unit, oid_type)
SELECT
     oid_string                         AS oid_string      
    ,oid_name                           AS oid_name           
    ,description                        AS description   
    ,syntax_type                        AS syntax_type        
    ,unit                               AS unit              
    ,oid_type                           AS oid_type      
FROM hive.snmp.snmp_oid_metadata_pg;


SET 'pipeline.name' = 'Push SNMP snmp_oid_metadata_mysql => fluss.snmp_oid_metadata';

INSERT INTO fluss.snmp.snmp_oid_metadata
    (oid_string, oid_name, description, syntax_type, unit, oid_type)
SELECT
     oid_string                         AS oid_string      
    ,oid_name                           AS oid_name           
    ,description                        AS description   
    ,syntax_type                        AS syntax_type        
    ,unit                               AS unit              
    ,oid_type                           AS oid_type      
FROM hive.snmp.snmp_oid_metadata_mysql;


SET 'pipeline.name' = 'Push SNMP snmp_oid_metadata_redis => fluss.snmp_oid_metadata';

INSERT INTO fluss.snmp.snmp_oid_metadata
    (oid_string, oid_name, description, syntax_type, unit, oid_type)
SELECT
     oid_string                         AS oid_string      
    ,oid_name                           AS oid_name           
    ,description                        AS description   
    ,syntax_type                        AS syntax_type        
    ,unit                               AS unit              
    ,oid_type                           AS oid_type      
FROM hive.snmp.snmp_oid_metadata_redis;