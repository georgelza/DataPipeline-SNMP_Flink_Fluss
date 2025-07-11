-- This table will mstly be small, in comparison to the poll_data table.
CREATE OR REPLACE TABLE fluss.snmp.snmp_device_info (
     device_id                  STRING PRIMARY KEY NOT ENFORCED     -- Unique identifier for the device
    ,ip_address                 STRING NOT NULL                     -- IP address of the device (IPv4 or IPv6)
    ,hostname                   STRING                              -- Hostname of the device
    ,device_location            STRING                              -- Physical location of the device
    ,device_type                STRING                              -- Type of device (e.g., "router", "switch", "server")
    ,vendor                     STRING                              -- Device vendor (e.g., "Cisco", "Juniper", "HP")
    ,devmodel                   STRING                              -- Device model
    ,firmware_version           STRING                              -- Firmware or OS version
    ,last_updated_ts            TIMESTAMP(3)  
    ,partition_month            STRING                              -- must be provided by upstream or insert logic
) WITH (
     'bucket.num'               = '1'
    ,'table.datalake.enabled'   = 'true'
);