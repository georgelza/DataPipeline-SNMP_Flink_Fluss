--
--   NOTE:   at the moment these use standard JDBC Connector, other words when the table is created as per below, it will then one time
--           fetch the data from the defined source table, any subsequent inserts into the source will not be in the below table
--
--           To have records added to the source also appear in the below table the CDC defined configuration is required.
--


-- Snmp_oid_metadata tables
CREATE TABLE hive.snmp.snmp_oid_metadata_mysql (
     oid_string         VARCHAR(255) PRIMARY KEY NOT ENFORCED               -- The numerical OID (e.g., ".1.3.6.1.2.1.1.1.0")
    ,object_name        VARCHAR(255)                                        -- The human-readable name (e.g., "sysDescr")
    ,data_type          VARCHAR(50)                                         -- The data type (e.g., "DisplayString", "Integer32")
    ,info               VARCHAR(2000)                                       -- The textual description from the MIB
    ,oid_type           VARCHAR(255)                                        -- "scalar", "table", "notification", etc.
    ,mib_module         VARCHAR(50)                                         -- Source file / Module Name
) WITH (
     'connector'             = 'jdbc'
    ,'url'                   = 'jdbc:mysql://mysqlsnmp:3306/snmp'           -- Replace with your DB URL
    ,'table-name'            = 'snmp_oid_metadata'                          -- The table name in your relational database
    ,'username'              = 'snmp'
    ,'password'              = 'abfr24'
    ,'lookup.cache.max-rows' = '1000'                                       -- Cache OID metadata
    ,'lookup.cache.ttl'      = '24h'                                        -- OID metadata changes rarely, so a long TTL is fine
);


CREATE TABLE hive.snmp.snmp_oid_metadata_pg (
     oid_string         VARCHAR(255) PRIMARY KEY NOT ENFORCED              
    ,object_name        VARCHAR(255)                                      
    ,data_type          VARCHAR(50)                            
    ,info               VARCHAR(2000)                   
    ,oid_type           VARCHAR(255)                              
    ,mib_module         VARCHAR(50)                                 
) WITH (
     'connector'             = 'jdbc'
    ,'url'                   = 'jdbc:postgresql://postgresqlsmp:5432/snmp'  -- Key Change: 'jdbc:postgresql' and default port 5432
    ,'table-name'            = 'public.snmp_oid_metadata'                   -- Key Change: Often includes schema, e.g., 'public.your_table'
    ,'username'              = 'dbadmin'
    ,'password'              = 'dbpassword'
    ,'lookup.cache.max-rows' = '1000'                       
    ,'lookup.cache.ttl'      = '24h'                     
);

-- Broken ATM
-- Selecting from this table... even with data on the source side fails...
CREATE TABLE hive.snmp.snmp_oid_metadata_redis (
     oid_string         VARCHAR(255) PRIMARY KEY NOT ENFORCED              
    ,object_name        VARCHAR(255)                                      
    ,data_type          VARCHAR(50)                            
    ,info               VARCHAR(2000)                   
    ,oid_type           VARCHAR(255)                              
    ,mib_module         VARCHAR(50)    
) WITH (
    'connector'             = 'redis',
    'hostname'              = 'redissnmp',
    'port'                  = '6379',
    'database'              = '0',
    'data-type'             = 'JSON',                                       -- Or 'STRING' if storing full JSON strings
    'lookup.cache.max-rows' = '1000',
    'lookup.cache.ttl'      = '24h',                                        -- OID metadata changes even less frequently
    'lookup.max-retries'    = '3',
    'key.prefix'            = 'oid:',                                       -- Prefix for your Redis keys (e.g., 'oid:1.3.6.1.2.1.1.3.0')
    'value.format'          = 'json'
    -- 'password' = 'your_redis_password'
);
