
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

5. 3.1.creFlussTarget.sql

  Create Apache Fluss Target tables.

6. 3.2.creFlussInserts.sql

  Insert into our Apache Fluss target tables from our Hive source tables.
