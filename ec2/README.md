# EC2

## Instance types

- 5 distinct characteristics:

    - RAM
    - CPU
    - I/O
    - Network
    - GPU

- R/C/P/G/H/X/F/Z/CR are specialised in RAM, CPU, I/O, Network, GPU

- M instance types are balanced (no GPU)

- T2, T3 are burstable

## Launch Types

- __On Demand Instance__: short workload, predictable pricing
    - Pay-as-you-go,
    
    - The highest cost but no upfront payment
    
    - No long term commitment

    - Recommended for short-term and un-interrupted workloads, where you can't predict how the application will behave

- __Reserved Instances__: long workloads
    
    - Up to 75% discount compared to On-demand

    - Pay upfront for what you use with long term commitment

    - Reservation period can be 1 or 3 years

    - __Reserve a specific instance type__

    - Recommended for steady state usage applications (Database)


- __Convertible Reserved Instances__: long workloads with flexible instances

    - Can change the EC2 instance type

    - Up to 54% discount


- __Scheduled Reserved Instances__: every Thursday between 3 and 6 pm

    - Launch within wtime window you reserve

    - When you require a fraction of day / week / month

- __Spot Instances__: short workloads, cheap, can lose instances

    - Can get a discount of up to 90% compared to On-demand

    - Instances can be losed at any point of time if your max price is less than the current spot price

    - The most cost-efficient instances in aws

    - __Useful for workloads that are resilient to failure__:
        - Batch jobs

        - Data analysis

        - Image processing
    
    - Not recommended for critical jobs or databases

    - Great combo: Reserved instances for baseline + on-demand 7 spot for peaks

- __Dedicated Instances__: No other customers will share your hardware

    - Instances running on hardware that's dedicated to you

    - May share hardware with other instances in same account, no share hardware with other customers

    - No control over instance placement


- __Dedicated Hosts__: book an entire physical server, control instance placement
    
    - Physical dedicated EC2 server for your use

    - Full control of EC2 instance placement

    - Visibility into the underlying sockets / physical cores of the hardware

    - Allocated for your account for a 3 year period reservation

    - More expensive

    - Useful for software that have complicated licensing model

    - For companies that have strong regulatory or compliance needs


## Elastic Network Interfaces (ENI)

- Logical component in a VPC that represents a __virtual network card__

- The ENI can have the following attributes:

    - Primary private IPv4, one or more secondary IPv4

    - One elastic IP (IPv4) per private IPv4
    
    - One or more security groups

    - A MAC address

- Can create ENi independently and attach them on the fly (move them) on EC2 instances for vailover

- Bound to a specific availability zone (ZA)

## Pricing

- EC2 instances prices (per hour) varies based on these parameters:
    
    - Region

    - Instance Type

    - Launch type

    - OS

- Billed by the second, with a minimum of 60 seconds
    - Example: t2.small in US-EAST-1, cost $0.023 per hour
        - 6s, it costs $0.023/60 = $0.000383 (minimum of 60s)
        - 60s, it costs $0.023/60 = $0.000383 (minimum of 60s)
        - 30m, it costs $0.023/2 = $0.00115
        - 1 month, it costs $0.023 * 24 * 30 = $16.56

- Other factors: storage, data transfer, fixed IP, load balancing

- You do not pay for the instance if the instance is stopped

## AMI

- Base images:
    - ubuntu
    - centos
    - redhat

- These images can be customised at runtime using EC2 User data

- AMI can be built for Linux or Windows machine

- Custom AMI can provide the following advantages:
    - Pre-installed packages
    - Faster boot time
    - Machine comes configured with monitoring / enterprise software
    - Security concerns

- __AMI are built for specific AWS region__

## EC2 User Data


- It is possible to lauching commands (EC2 User Data script) when a machine starts.

- That script is only run once at the instance first start

- EC2 user data is used to automate boot tasks such as:
    - install updates
    - install software

- EC2 user data script runs with the root user


## Checklist

- SSH into EC2
- Properly use security group
- Private vs public vs elastic IP
- User data
- AMI to enhance OS
- EC2 instances are billed by second and can be easily created and thrown away

## Notes

- __Pay__ for an EC2 instance if it's __running__ state

- Getting a __permission error__ exception when trying to SSH, the key is missing permissions __chmod 0400__

