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

## EFS (Elastic File System)

- Managed NFS (network file system) that can be mounted on many EC2

- EFS works with EC2 instances in multi-AZ

- Highly available, scalable, expensive (3 x gp2), pay per user

- Use cases: content management, web serving, data sharing, wordpress

- Uses NFSv4.1 protocol

- Uses securtiy group to control access to EFS

- __Compatible with linux based AMI (not windows)__

- Encryption at rest using KMS

- POSIX file system (~linux) that has a standard file API

- File system scales automatically, pay-per-use, no capacity planning

- Scale:
    - 1000s of concurrent NFS clients, 10GB+ /s throughput

    - Grow to Petabyte-scale network file system, automatically

- Performance mode (set at EFS creation time):
    - General purpose (default): latency-sensitive use cases (web server, CMS, ...)
    - Max I/O - higher latency, throughput, highly parall (big data, media processing)

- Storage Tiers
    - Lifecycle management feature - move file after N days
    
    - Standard: for frequently accessed files

    - Infrequent access (EFS-IA): cost to retrievie files, lower price to 


## Notes

### EBS:
- Can be attached to only one instance at a time

- EBS was locked into a single AZ

- Types:
    - gp2: IO increases if the dis size increases
    - io1: can increase IO independently 

- To migrate an EBS volume across AZ
    - Take a snapshot
    - Restore the snapshot to another AZ
    - EBS backups use IO and you shound not run them while your app is handling a lot of traffic

- Root EBS volumes of instances get terminated by default if the EC2 instance gets terminated

### EFS

- Mounting 100s of instances across AZ

- EFS share files

- Only for linux instances (POSIX)

- EFSF has a higher price point than EBS

- Can leverage EFS-IA (Infrequent Access) for cost savings

