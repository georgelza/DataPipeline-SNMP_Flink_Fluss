
# Data Flows


1. 1.creCat.sql

   1. Create the hive catalog

   2. Create the snmp database inside the hive catalog.

   3. Create the fluss catalog

   4. Create the snmp database inside the fluss catalog
  
  
2. 2.1.snmp_poll_data_get.sql

  Various SNMP GET fetches.

3. 2.1.snmp_poll_data_walk.sql

  Various SNMP WALK data fetches.

4. 2.1.snmp_poll_data_auth.sql

  SNMP GET and WALK data fetches, but with SNMPv3 authentification.

5. 3.*.creSnmp_*_FlussTargets.sql

  Create Apache Fluss Target tables.

6. 4.*.creSnmp_*_FlussInserts.sql

  Create Apache Flink Insert jobs sourcing from 2.* into 3.*
 