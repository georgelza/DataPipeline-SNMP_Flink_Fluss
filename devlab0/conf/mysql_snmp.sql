
CREATE DATABASE IF NOT EXISTS snmp;
use snmp;

-- create snmp_oid_metadata table
CREATE TABLE IF NOT EXISTS snmp.snmp_oid_metadata (
     oid_string          VARCHAR(255) PRIMARY KEY                   -- The numerical OID (e.g., ".1.3.6.1.2.1.1.1.0")
    ,oid_name            VARCHAR(255)                               -- The human-readable name (e.g., "sysDescr")
    ,oid_description     VARCHAR(2000)                              -- The textual description from the MIB
    ,syntax_type         VARCHAR(255)                               -- The data type (e.g., "DisplayString", "Integer32")
    ,unit                VARCHAR(50)                                -- Optional: units (e.g., "seconds", "bytes")
    ,oid_type            VARCHAR(50)                                -- Optional: "scalar", "table", "notification", etc.
);

-- create snmp_device_info table
CREATE TABLE IF NOT EXISTS snmp.snmp_device_info (
     device_id           VARCHAR(255) PRIMARY KEY                   -- Unique identifier for the device
    ,ip_address          VARCHAR(45) NOT NULL                       -- IP address of the device (IPv4 or IPv6)
    ,hostname            VARCHAR(255)                               -- Hostname of the device
    ,device_location     VARCHAR(1000)                              -- Physical location of the device
    ,device_type         VARCHAR(100)                               -- Type of device (e.g., "router", "switch", "server")
    ,vendor              VARCHAR(100)                               -- Device vendor (e.g., "Cisco", "Juniper", "HP")
    ,model               VARCHAR(100)                               -- Device model
    ,firmware_version    VARCHAR(100)                               -- Firmware or OS version
    ,last_updated_ts     TIMESTAMP(3)                               -- Timestamp of the last update to this device's info
); 

-- device_location => BN:xxx/FN:xxx/NR:xxx/RN:xxx/UN:xxx
-- BN => Building name
-- FN => Floor Number
-- NR => Network Room Number or NR => DC Room Number
-- RCKN => Rack Number or RWN =>
-- UN => Top U Number of device

-- or

-- device_location => BN:xxx/FN:xxx/DCRN:xxx/RN:xxx/RCKN:xxxx/UN:xxx
-- BN => Building name
-- FN => Floor Number
-- DCRN => DC Room Number
-- RN => Row Number
-- RCKN => Rack Number
-- UN => Top U Number of device

-- INSERT statement for snmp.snmp_oid_metadata
-- This table stores information about SNMP OIDs (Object Identifiers).
INSERT INTO snmp.snmp_oid_metadata (
     oid_string
    ,oid_name
    ,oid_description
    ,syntax_type
    ,unit
    ,oid_type
) VALUES (
     '.1.3.6.1.2.1.1.1.0'                           -- oid_string: The numerical OID
    ,'sysDescr'                                     -- oid_name: Human-readable name
    ,'A textual description of the entity. This value should include the full name and version identification of the system''s hardware type, software operating-system, and networking software.' -- oid_description: Description from MIB
    ,'DisplayString'                                -- syntax_type: Data type
    ,NULL                                           -- unit: Optional unit (NULL if not applicable)
    ,'scalar'                                       -- oid_type: Type of OID (e.g., "scalar", "table")
);

INSERT INTO snmp.snmp_oid_metadata (
     oid_string
    ,oid_name
    ,oid_description
    ,syntax_type
    ,unit
    ,oid_type
) VALUES (
     '.1.3.6.1.2.1.2.2.1.10'                        -- ifInOctets (example for a table column)
    ,'ifInOctets'                       
    ,'The total number of octets received on the interface, including framing characters.' 
    ,'Counter32'                      
    ,'octets'                       
    ,'table'                           
);

-- INSERT statement for snmp.snmp_device_info
-- This table stores information about network devices.
INSERT INTO snmp.snmp_device_info (
     device_id
    ,ip_address
    ,hostname
    ,device_location
    ,device_type
    ,vendor
    ,model
    ,firmware_version
    ,last_updated_ts
) VALUES (
     '172.16.10.2:161'                              -- device_id: Unique identifier for the device
    ,'72.16.10.2'                                   -- ip_address: IP address
    ,'UnifiProMax-24PoE'                            -- hostname: Hostname
    ,'BN:11/FN:01/DCRN:Study/RN:01/RCKN:01/UN:10'   -- device_location: Physical location
    ,'Switch'                                       -- device_type: Type of device
    ,'Unifi'                                        -- vendor: Device vendor
    ,'Pro-Max24PoE'                                 -- model: Device model
    ,'IOS XE 17.6.1a'                               -- firmware_version: Firmware/OS version
    ,NOW(3)                                         -- last_updated_ts: Current timestamp with milliseconds
);

INSERT INTO snmp.snmp_device_info (
     device_id
    ,ip_address
    ,hostname
    ,device_location
    ,device_type
    ,vendor
    ,model
    ,firmware_version
    ,last_updated_ts
) VALUES (
     '172.16.10.3:161'                             
    ,'72.16.10.3'                             
    ,'UnifiAggregation'                           
    ,'BN:11/FN:01/DCRN:Study/RN:01/RCKN:01/UN:05'  
    ,'Switch'                                 
    ,'Unifi'                                
    ,'Aggregation'                               
    ,'IOS XE 17.6.1a'                             
    ,NOW(3)                                        
);