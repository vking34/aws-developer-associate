# EBS & EFS

## EBS - Elastic block Store

### Overview
- EBS volume is a network drive, used to persist data, you can attach to your instances while they run

- It's locked to an AZ
    - Example: EBS volume in us-east-1a can not be attached to us-east-1b
    - To move a volume across, you first need to snapshop it

- Have a provisioned capacity (size in GBs and IOPS - I/O per sec)

### Types

- GP2 (SSD): general purpose. balances with price and performance
    - Recommended for most workloads
    - System boot volumes
    - Virtual desktops
    - Low-latency interactive apps
    - Development and test environments

    - 1 GB - 16 TB
    - can burst IOPS to 3000
    - Max IOPS: 1600
    - 3 IOPS per GB, means at 5334GB we are at the max IOPS

- IO1 (SSD): highest-perfomance.
    - Critical business applications that require systained IOPS performance, or more than 16000IOPS per volume
    - Large database workloads: MongoDB, Cassandra, Microsoft
    - 4 GB - 16 TB
    - IOPS is provisioned min 100 - max 64000 (Nitro isntances) else MAX 32000 (other)
    - max 50 IOPS per GB

- ST1 (HDD): low cost, frequently accessed
    - Streaming workloads requiring consistent, fast throughput at low price.
    - Big data, data warehouses, log processing, Kafka
    - Can not be a boot volume

    - 500GB - 16TB
    - Max IOPS is 500
    - Max throughput of 500MB/s 

- SC1 (HDD): lowest cost, lass frequently accessed
    - throughput-oriented storage for large volumes of data that is infrequently accessed
    - Can not be boot volume
    - 500GB - 16TB
    - Max IOPS is 500
    - MAx throughput of 250 MB/s

## EBS vs Instance Store

### Instance Store
- Some instance do not come with Root EBS volumes
- Instead, they come with "Instance store" (=ephemaral storage)
- Instance store is physically attached to the machine

- Pros:
    - Better I/O performance, very high IOPS
    - Good for buffer / cache / scratch data / temporary content
    - Data survives reboots

- Cons:
    - On stop or termination, the instance store is lost
    - You can not resize
    - Backups must be operated by the user

