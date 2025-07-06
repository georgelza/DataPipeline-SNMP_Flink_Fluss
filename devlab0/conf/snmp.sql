
-- create snmp_oid_metadata table
CREATE TABLE IF NOT EXISTS public.snmp_oid_metadata (
    oid_string          VARCHAR(255) PRIMARY KEY,                   -- The numerical OID (e.g., ".1.3.6.1.2.1.1.1.0")
    oid_name            VARCHAR(255),                               -- The human-readable name (e.g., "sysDescr")
    description         VARCHAR(2000),                              -- The textual description from the MIB
    syntax_type         VARCHAR(255),                               -- The data type (e.g., "DisplayString", "Integer32")
    unit                VARCHAR(50),                                -- Optional: units (e.g., "seconds", "bytes")
    oid_type            VARCHAR(50)                                 -- Optional: "scalar", "table", "notification", etc.
);

-- create snmp_device_info table
CREATE TABLE IF NOT EXISTS public.snmp_device_info (
    device_id           VARCHAR(255) PRIMARY KEY,                   -- Unique identifier for the device
    ip_address          VARCHAR(45) NOT NULL,                       -- IP address of the device (IPv4 or IPv6)
    hostname            VARCHAR(255),                               -- Hostname of the device
    device_location     VARCHAR(1000),                              -- Physical location of the device
    device_type         VARCHAR(100),                               -- Type of device (e.g., "router", "switch", "server")
    vendor              VARCHAR(100),                               -- Device vendor (e.g., "Cisco", "Juniper", "HP")
    model               VARCHAR(100),                               -- Device model
    firmware_version    VARCHAR(100),                               -- Firmware or OS version
    last_updated_ts     TIMESTAMP(3)                                -- Timestamp of the last update to this device's info
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