# DynamoDB

- NoSQL Serverless DB

- Fully managed, highly available with replication across 3 AZ

- Millions of req per seconds, trillions of row

- Fast and consistent in performace

- Enables event driven programming with DynamoDB streams

- Low cost and auto scaling capabilities


## Basics

- Maximum size of a item is 400KB

- Data types supported are:
    - Scalar types: String, Number, Binary, Boolean, Null
    - Document Types: List, Map
    - Set types: String Set, Number Set, Binary Set

- Primary keys:
    - Opt 1: Partition key only (HASH)
        - Partition key must be unique
        - Partition key must be diverse so that the data is distributed

    - Opt 2: Partition key + Sort Key
        - The combination must be unique
        - Data is grouped by partition key
        - Sort key == range key
    
## Throughput

- Read Capacity Units (RCU)
- Write Capacity Units (WRU)

- Option to setup auto-scaling of throughput to meet demand

- If burst credit are empty, u will get a "ProvisionedThroughputException"

- It's then advised to do an exponential bac-off retry

### WCU

- One WRU represents __1 write per second for an item up to 1 KB in size__

- If the items are larger than 1 KB, more WCU are consumed

- Example:
    - 10 objects per seconds of 2KB each: 10 * 2 = 20 WCU
    - 6 objects per seconds of 4.5KB each: 6 * 5 = 30 WCU. (4.5 get rounded to the upper)
    - 120 objects per minute of 2 KB each: 120 / 60 * 2 = 4 WCU

### RCU

- Eventually consistent Read (default): if we read just after a write, its possible we will get unexpected response because of replication

- Strongly Consistent Read: if we read just after a write, we will get the correct data

- One RCU represents __1 strongly consistent read per second, or 2 eventually consistent reads per second, for an item up to 4KB in size__

- If the items are larger than 4KB, more RCU are consumed


### Partitions Internal

- Data is divided in partitions 

- Partition keys go through a hashing algorithm to know to which partition they go to

- To compute the number of partitions:
    - By capacity: (TOTAL RCU / 3000) + (TOTAL WCU / 1000)
    - By size: TOTAL SIZE / 10 GB

    - Total partitions: CEILING(MAX(Capacity, Size))

- __WCU and RCU are spread evenly between partitions__

### Throttling

- If we exceed our RCU or WCU, we get __ProvisionedThroughputExceededExceptions__

- Reasons:
    - Hot keys: one partition key is being read too many times (popular item for ex)

    - Hot partitions
    
    - Very large items: remember RCU and WCU depends on size of items

- Solutions:
    - Exponential back-off when exception is encountered (already in SDK)

    - Distribute partion keys as much as possible

    - If RCU issues, we can use DynamoDB Accelerator (DAX - cache)

## APIs

- Conditional Writes:
    - Accept a write / update only if conditions are respected, otherwise reject

    - Helps with concurrent access to items

    - No performance impact

- BatchWirteItems
    - Up to 25 PutItem and/or DeleteItem in one call

    - Up to 16MB of data written

    - Up to 400KB of data per item

    - Batching allows u to save in latency by reducing the number of API calls done against DynamoDB

    - Operations are done in parallel for better efficiency

    - It's possible for part of a batch to fail, in which case we have the try the failed items (using exponential back-off algorithm)

- GetItem:
    - Up to 100 items

    - Up to 16MB of data

    - Items are retrieved in parallel to minimize latency

- Query:

    - PartitionKey value (__must be = operator__)
    - SortKey value (=, <, <=, =>, >, between, begin with) - optional

    - __FilterExpression__ to further filter (__client side filtering__)

    - Returns:
        - Up to 1MB of data
        - Or number of items specified in Limit

        - Able to pagination on the results

        - Can query table, a local secondary index, or a global secondary index

- Scan:
    - The entire table and then filter out data (inefficient)

    - Returns up to 1MB of data - use pagination to keep on reading

    - Consumes a lots of RCU

    - Limit impact using Limit or reduce the size of the result and pause

    - For faster performance, use parallel scans:
        - Multiple instances scan multiple partitions at the same time

        - Increase the throughput and RCU consumed

        - Limit the impact of parallel scans just like u would for scans

    - Can use a __ProjectExpression + FilterExpression__ (no change to RCU)


## Indexes

### Local Secondary Index - LSI

- __Alternate range key for your table__, local to the hash key

- Up to 5 local secondary indexes per table

- The sort key consists of exactly one scalar attribute

- The attribute that u choose must be a String, Number, or Binary

- LSI must be defined at table creation time


### Global Secondary Index - GSI

- To __speed up queries on non-key attributes__, use a Global Secondary Index

- GSI = partition key + optional sort key

- The index is a new "table" and we can project attributes on it

    - The partition key and sort key of the original table are always projected (KEYS_ONLY)

    - Can specify exrta attributes to project (INCLUDE)

    - Can use all attributes from main table (ALL)

- Must define RCU / WCU for the index

- Possiblitity to add / modify GSI (not LSI)

### Throttling

- GSI:
    - __If the writes are throttled on the GSI, then the main table will be throttled!__

    - Even if the WCU on the main tables are fine

    - Choose your GSI partion key carefully

    - Assign your WCU capacity carefully

- LSI:
    - Uses the WCU and RCU of the main table
    - No spcial throttling considerations

## DAX - DynamoDB Accelerator

- Seamless cache for DynamoDB, no app re-write

- Writes go through DAX to DynamoDB

- Solves the hoy key problem (too many reads)

- 5 min TTL for cache by default

- Up to 10 nodes in the cluster

- Multi AZ (3 nodes minimum recommended for production)

- Secure (Encryption at rest with KMS, VPC, IAM, ...)

## Streams

- Stream has 24 hours of data retention

- Could implement cross region replication using Streams

- Choose the info that will be written to the stream whenever data is modified
    - KEYS_ONLY - only the key attributes of the modified item

    - NEW_IMAGE
    - OLD_IMAGE
    - NEW_AND_OLD_IMAGES

- DynamoDB Streams are made of shards, just like Kinesis Data Streams

- You dont provision shards, this is automated by AWS

- Records are not retroactively populated in a stream after enabling it


### With Lambda

- Define an Event Source Mapping to read from a DynamoDb Streams

- Ensure the Lambda function has the appropriate permissions

- Your Lambda function is __invoked synchronously__

## TTL

- TTL is enabled per row

- DynamaDB typically deletes expired items within 48 hours of expiration

- Deleted items due to TTL are also deleted in GSI / LSI

- DynamoDB Streams can help recover expired items


## CLI

- --projection-expression: attributes to retrieve

- --filter-expression: filter results

- General CLI pagination options including DynamoDB/S3:
    - Optimization:
        - --page-size: full dataset is still received but each API call will request less data (helps avoid timeouts)

    - Pagination:
        - --max-items: max number of results returned by CLI. Returns NextToken

        - --starting-token: specify the last received NextToken to keep on reading

## Transactions

- Write Modes: Standard, Transactional

- Read Modes: Eventual consistency, Strong consistency, Transactional

- Consume 2x of WCU / RCU

## Session State Cache

- vs ElasticCache:
    - EC is in-memory, but DynamoDB is serverless
    - Both are key/value store

- vs EFS:
    - EFS must be attached to EC2 instances as network drive

- vs EBS & instance store:
    - EBS & Instance store can only be used for local caching, not shared caching

- vs S3:
    - S3 is higher latency, and not meant for small objects

## Write Sharding

- If there are few partition keys, we will run into partitions issues

- Solution: add a suffix (usually __random suffix__, sometimes calculated suffix)

## Write Types

- Concurrent Writes

- Conditional Writes

- Atomic Writes: Ex. increase value

- Batch Writes

## Operations

### Copying a DynamoDB table:

- Opt1: use AWS Datapipline + EMR

- Opt2: Create a backup and restor the backup into a new table name

- opt3: Scan + write

## Security

- VPC endpoints available to access DynamoDB without internet

- Access fully controlled by IAM

- Encryption at rest using KMS

- Encryption in transit using SSL

## Other Features

- Backup & Restore
    - Point in time restore like RDS
    - No performace impact

- Global Tables
    - Multi region, fully replicated , high performace

- DMS can be used to migrate to DynamoDB (from Mongo, S3, ...)
