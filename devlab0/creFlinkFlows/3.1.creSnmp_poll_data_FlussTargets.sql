-- This table will grow large as it will have multiple records for every poll from every snmp agent defined.
CREATE OR REPLACE TABLE fluss.snmp.snmp_poll_data (
     device_id                  STRING                                  -- Foreign key referencing snmp_device_info.device_id
    ,metric_oid                 STRING                                  -- Object Identifier (OID) of the polled metric
    ,metric_value               STRING                                  -- The value of the metric (store as string for flexibility)
    ,data_type                  STRING                                  -- The SNMP data type (e.g., "Gauge", "Counter", "Integer", "OctetString")
    ,instance_identifier        STRING                                  -- For table-based OIDs (e.g., interface index)
    ,ts                         STRING                                  -- Timestamp when the data was collected/scraped
    ,partition_month            STRING                                  -- must be provided by upstream or insert logic
) PARTITIONED BY (partition_month) WITH (
     'bucket.num'                         = '3'
    ,'table.datalake.enabled'             = 'true'
    ,'table.auto-partition.time-unit'     = 'MONTH'
    ,'table.auto-partition.num-precreate' = '5'
    ,'table.auto-partition.num-retention' = '60'
    ,'table.auto-partition.time-zone'     = 'Africa/Johannesburg'
);

-- See: https://alibaba.github.io/fluss-docs/docs/table-design/data-distribution/partitioning/#partition-generation-rules
-- For the setup around Auto Partitioning.

SHOW PARTITIONS fluss.snmp.snmp_poll_data;
