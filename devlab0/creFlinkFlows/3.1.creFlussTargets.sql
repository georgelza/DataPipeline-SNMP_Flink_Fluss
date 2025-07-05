-- Fluss table with flattened data from North, South and East tables.
CREATE OR REPLACE TABLE fluss.snmp.snmp_poll_data (
     device_id               VARCHAR(255) NOT NULL              -- Foreign key referencing snmp_device_info.device_id
    ,metric_oid              VARCHAR(255) NOT NULL              -- Object Identifier (OID) of the polled metric
    ,metric_value            VARCHAR(1000)                      -- The value of the metric (store as string for flexibility)
    ,data_type               VARCHAR(50)                        -- The SNMP data type (e.g., "Gauge", "Counter", "Integer", "OctetString")
    ,instance_identifier     VARCHAR(255)                       -- For table-based OIDs (e.g., interface index)
    ,ts                      TIMESTAMP(3)                       -- Timestamp when the data was collected/scraped
    ,partition_month         STRING                             -- must be provided by upstream or insert logic
    ,WATERMARK FOR ts AS ts - INTERVAL '5' SECONDS              -- Adjust watermark delay as needed - event time
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

SHOW PARTITIONS fluss.fluss.snmp_poll_data;
