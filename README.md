# A Proposal to uitlize Modern Realtime Datastreaming Technologies to Manage Data centre's resources.

All via Apache Flink + SNMP Source Connector with real time analytical data storage provided via Apache Fluss.

## Overview

How can we re-vitalize a industry standard technology like SNMP (Simple Network Management Protocol), using modern data streaming concepts to improve monitoring, managment, proactive maintenance to protect our ever increasing reliance in larger and larger data center due to technologies like AI, ML, RAG, etc... there are many more new 3 letter acronyms if you go looking.

If anyone has ever looked at SNMP, they would have notice the sheer volume of information available, exposed. It also maps very well to the root concepts coined during the early days BIG Data, namely VVV (Velocity, Volume, Variety).

With this we do sit with the problem that VVV also causes, how do we manage it, how do we consume the data volume, store the volume, expose abnormalities.

To analyse it, well we have all the 3LA (Three Letter Acronyms) as previously, AI, ML, RAG, MCP... But none of these are of any value if we don't have data to work with.

SNMP itself is a old technology, but it was never build for the modern world, for the new volumes we are talking here about, and it has no "concept" of our very popular 3LA demanding/getting all the attention.

And here we sit, lets introduce modern Data streaming technologies... Let's use these concepts to source our data and get it to our 3LA project of choice.


This is the combination of 1, 2 no more like 3 projects.

1. The first was this idea, this blog, but it then required project 2, 

2. Write an apache Flink SNMP source connector, and then project 3, 

3. The ability to load SNMP MIB files into a designated table to be accessible via our apache Flink/Apache Fluss stack. 


Well, project 1 is done (You reading it, hehehe), project 2 is 90% done (SNMPv3 auth outstanding), project 3... lets not talk, or well, maybe by the time you read this I might have completed it, at this stage it's still a piece of work in progress, it's an "addition" to the core project... so going to use that as excuse why it's not done yet.

First up, I am not a developer by trade, more like by a side hppby, as far as my day job is concerned, I'm a technologist, a  Technology Architect, but for 25+ yrs I've primarily specialized in the data space, with a curious mind that get me into allot of trouble... 

Java is not my language, make that never have been, I'm mildly proficient in Python and Golang, never written Java until I started looking at **Apache Flink** source connectors...

As such, I had the idea, and between *Google Gemini* and myself we had allot of conversations, arguments, restarts. Giving it the right comments, questions you can make it eventually provide you with the correct structured framework. At which point I added the bits I figured I needed.

Eventually I got the [Apache Flink SNMP Source Cnnector](https://github.com/georgelza/SNMP-Flink-Source-connector.git) completed. 

Learned allot and can't say I'm not mildly impressed with what I created.


[GIT REPO](https://github.com/georgelza/DataPipeline-SNMP_Flink_Fluss.git)


### Building the project

First, go and build the SNMP Source connector, other words, git clone the above project, read the README.md in the root to build the jar file. Then come back here.

Now copy the shaded jar to the `devlab/conf/flink/lib/flink` which will be mounted to our Apache Flink Jobmanager's `Flink_Home/lib` directory. 

Once the above is done we return here... At this point we need to build the basic bits from the `infrastructure` section. This will build our **HDFS** cluster, which provides the storage layer required by our **Apache Fluss** environment for it's `lakehouse` storage tier.

We will extend our **Apache Flink** environment, adding the jar's needed to connect with our **Apache Fluss** environment.
Then nothing is anything without a catalog, here we have our **Apache Hive Meta Store**, aka **HMS**, backed by a **PostgreSQL** database.

Building all of this is defined in `infrastructure/README.md` file.

Once we have all of this build, then we return to this root directory, and move into the devlab0 subdirectory, where we start with the README.md file.

This is pretty simple from here on, the instructions are in the previous READMe.md.


## SNMP Sources...

To run/explore this project you will, as guessed need some snmp capable end points/agents. Pretty much every enterprise hardware piece does, be that switches, servers, storage components, PDU (Power Distrubution units), Datacenter Cooling, Data Center UPS solutions, you think it, it probably does.

At home, most of your name brand NAS solutions will (i.e [TrueNAS](https://www.truenas.com)), most of your home Fiber or ADSL routers will also have the ability once enabled. 

Or as a last resort, we have as per below 2 links which create fake SNMP data output, one is a standalone Python program that can simulate SNMP agents/points, the second is a commercial product, but sure you can get a trial license. Pretty sure there is more if you go looking.

- Python App    -> [SNMPSIM](https://github.com/etingof/snmpsim)
                -> [lextudio](https://docs.lextudio.com/snmpsim/)
- Python App    -> [PySNMP](https://github.com/etingof/pysnmp
- Python App    -> [SNMPPoster](https://github.com/cluther/snmposter)
- SNMP Simulator-> [SNMP Simulator](https://snmp-simulator.soft112.com/#google_vignette) 
- Mimic         -> [SNMP Simulator](http://www.gambitcomm.com/)
- Article       -> [Read how Cisco benefits from MIMIC](https://www.gambitcomm.com/site/news/pdfs/Cisco_casestudy.pdf)

Which ever SNMP source you have, you will need to configure this into the `devlab0/creFlinkFlows/2.1*.sql` tables.


### Executing Polling Job

This all starts by executing:

- `cd devlab0`
- `make run`, followed by 
- `make deploy`. You can now open the Apache Flink, Flink SQL client using 
- `make fsql`. 


```SQL
use hive.snmp;

select * from hive.snmp.snmp_poll_data#;

```

This will print to the screen the data retrieved from the SNMP Agent.

At this point we want to push this to our **Apache Fluss** stack. This starts by executing `make targets`. This will create our **Apache Fluss** target tables. To try and keep it simple, ye we lost that battle long ago, for now I'm just storing all data locally, on disk, aka not on HDFS...

Once we know this works you can execute the `make inserts` command as defined in the `Makefile` located in the below infrastructure's `./devlab0` directory, see `./devlab0/README.md` 

This will push our **Apache Fluss** data from the **Apache Fluss** cluster (which is based on **Apache Arrow**) down into our `lakehouse` storage tier which is currently based on **Apache Paimon**, using **Apache Parquet** files to be stored on **HDFS** or **S3**


### References

**SNMP**
- [SNMP Protocol](https://en.wikipedia.org/wiki/Simple_Network_Management_Protocol)

- [SNMP by Techtarget](https://www.techtarget.com/searchnetworking/definition/SNMP)

- [Getting Started with SNMP](https://www.easysnmp.com/tutorial/getting-snmp-data/)

- [Lisa's Home Page: SNMP Simulator](https://www.rushworth.us/lisa/?p=11032)
 
**Apache Flink**
- [Ververica, original creators of Apache Flink](https://www.ververica.com)

- [Apache Flink Home](https://flink.apache.org)

- [Apache Flink GIT](https://github.com/apache/flink)

**Apache Fluss**  
- [Apache Fluss Home](https://fluss.apache.org/)

- [What is Fluss / Introduction Page](https://fluss.apache.org/docs/intro/)

- [Apache Fluss GIT](https://github.com/apache/fluss)
  
- [Apache Fluss Docs](https://alibaba.github.io/fluss-docs/)

- [Apache Paimon](https://paimon.apache.org)

- [Apache Parquet](https://parquet.apache.org)
  

### By:

George

[georgelza@gmail.com](georgelza@gmail.com)

[George on Linkedin](https://www.linkedin.com/in/george-leonard-945b502/)

[George on Medium](https://medium.com/@georgelza)

