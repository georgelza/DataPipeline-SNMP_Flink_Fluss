-- This table will mstly be small, in comparison to the poll_data table.
CREATE OR REPLACE TABLE fluss.snmp.snmp_oid_metadata (
     oid_string         STRING PRIMARY KEY NOT ENFORCED     -- The numerical OID (e.g., ".1.3.6.1.2.1.1.1.0")
    ,object_name        STRING                              -- The human-readable name (e.g., "sysDescr")
    ,data_type          STRING                              -- The data type (e.g., "DisplayString", "Integer32", "TimeTicks")
    ,info               STRING                              -- The textual description from the MIB
    ,oid_type           STRING                              -- "scalar", "table", "notification", etc.
    ,mib_module         STRING                              -- Source file / Module Name
) WITH (
     'bucket.num'               = '1'
    ,'table.datalake.enabled'   = 'true'
);