-- Snmp_oid_metadata tables
CREATE TABLE hive.snmp.snmp_oid_metadata_mysql (
     oid_string          VARCHAR(255) PRIMARY KEY NOT ENFORCED              -- The numerical OID (e.g., ".1.3.6.1.2.1.1.1.0")
    ,oid_name            VARCHAR(255)                                       -- The human-readable name (e.g., "sysDescr")
    ,oid_description     VARCHAR(2000)                                      -- The textual description from the MIB
    ,syntax_type         VARCHAR(255)                                       -- The data type (e.g., "DisplayString", "Integer32")
    ,unit                VARCHAR(50)                                        -- Optional: units (e.g., "seconds", "bytes")
    ,oid_type            VARCHAR(50)                                        -- Optional: "scalar", "table", "notification", etc.
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
     oid_string          VARCHAR(255) PRIMARY KEY NOT ENFORCED              
    ,oid_name            VARCHAR(255)                                      
    ,oid_description     VARCHAR(2000)                            
    ,syntax_type         VARCHAR(255)                   
    ,unit                VARCHAR(50)                              
    ,oid_type            VARCHAR(50)                                 
) WITH (
     'connector'             = 'jdbc'
    ,'url'                   = 'jdbc:postgresql://postgresqlsmp:5432/snmp'  -- Key Change: 'jdbc:postgresql' and default port 5432
    ,'table-name'            = 'public.snmp_oid_metadata'                   -- Key Change: Often includes schema, e.g., 'public.your_table'
    ,'username'              = 'dbadmin'
    ,'password'              = 'dbpassword'
    ,'lookup.cache.max-rows' = '1000'                       
    ,'lookup.cache.ttl'      = '24h'                     
);


CREATE TABLE hive.snmp.snmp_oid_metadata_redis (
     oid_string          VARCHAR(255) PRIMARY KEY NOT ENFORCED              -- The numerical OID (e.g., ".1.3.6.1.2.1.1.1.0")
    ,oid_name            VARCHAR(255)                                       -- The human-readable name (e.g., "sysDescr")
    ,description         VARCHAR(2000)                                      -- The textual description from the MIB
    ,syntax_type         VARCHAR(255)                                       -- The data type (e.g., "DisplayString", "Integer32")
    ,unit                VARCHAR(50)                                        -- Optional: units (e.g., "seconds", "bytes")
    ,oid_type            VARCHAR(50)                                        -- Optional: "scalar", "table", "notification", etc.
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
