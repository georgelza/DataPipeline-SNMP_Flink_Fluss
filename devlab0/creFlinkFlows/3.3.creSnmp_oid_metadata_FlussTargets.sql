
CREATE OR REPLACE TABLE fluss.snmp.snmp_oid_metadata (
     oid_string                 STRING PRIMARY KEY NOT ENFORCED   -- The numerical OID (e.g., ".1.3.6.1.2.1.1.1.0")
    ,oid_name                   STRING                            -- The human-readable name (e.g., "sysDescr")
    ,oid_description            STRING                            -- The textual description from the MIB
    ,syntax_type                STRING                            -- The data type (e.g., "DisplayString", "Integer32")
    ,unit                       STRING                            -- Optional: units (e.g., "seconds", "bytes")
    ,oid_type                   STRING                            -- Timestamp when the data was collected/scraped
    ,partition_month            STRING                            -- must be provided by upstream or insert logic
) WITH (
     'bucket.num'               = '1'
    ,'table.datalake.enabled'   = 'true'
);