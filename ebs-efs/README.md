# EBS - EFS

## EBS (Elastic Block Store)

### Types:

- GP2:
    - max IOPS: 1600

- IO1:
    - max IOPS: 6400

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

