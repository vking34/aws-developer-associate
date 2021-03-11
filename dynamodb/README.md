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

- One WRU represents one write per second for an item up to 1 KB in size

- If the items are larger than 1 KB, more WCU are consumed

- Example:
    - 10 objects per seconds of 2KB each: 10 * 2 = 20 WCU
    - 6 objects per seconds of 4.5KB each: 6 * 5 = 30 WCU. (4.5 get rounded to the upper)
    - 120 objects per minute of 2 KB each: 120 / 60 * 2 = 4 WCU

### RCU

- Eventually consistent Read: if we read just after a write, its possible we will get unexpected response because of replication

- Strongly Consistent Read: if we read just after a write, we will get the correct data