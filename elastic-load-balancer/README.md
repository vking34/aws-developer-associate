# Elastic Load Balancer - ELB

## Load Balancing

- Load balancers are servers that forward internet traffic to multiple servers downstream.

## Why use a load balancer?

- Spread load across multiple downstream instances

- Expose a single point of access (DNS) to the application

- Seamlessly handle failures of downstream instances

- Do regular health checks to your instances

- Provide SSL termination (HTTPS) for your websites

- Enforce stickness with cookies

- High availability across zones

- Separate public traffic from private traffic

## Why ELB?

- ELB is a managed load balancer

- AWS guarentees that it will be working

- AWS takes care of upgrades


## Types

- 3 types of managed LB:
    - __Classic Load Balancer__ (v1 - old generation - 2009):
        - HTTP, HTTPS, TCP

        - Fixed hostname: xxx.region.elb.aws.com

    - __Application Load Balancer__ (v2 - new generation - 2016)*:
        - HTTP, HTTPS(/2), Websocket

        - Load balancing to multiple HTTP application across machines (target groups)

        - Load balancing to multiple applications on the same machine (ex: containers)

        - Fixed hostname


    - __Network Load Balancer__ (v2 - new generation - 2017):
        - TCP, TLS, UDP

        - To instances

        - Handle millions of request per seconds

        - Less latency ~ 100ms (vs 400ms for ALB)

        

- You can setup __internal__ or __external__ ELB

## Troubleshooting

- Load Balancer Error 503 means at capacity (overload) or no registered terget

- If LB can not connect to your application, check your security groups


## Checklist

## Types

- Classic Loader Balancer
    - expose a static DNS
- Application Loader Balancer
    - expose a static DNS
- Network Loader Balancer
    - expose a public static IP

## Cross-Zone Load Balancing

- Cross Zone Load Balanacing: each load balancer instance distributes evenly across all registered instances in all AZ

- Classic Load Balancer:

    - Disabled by default

    - Enabled:
        - No charges for inter AZ
        - Charges for 

- Application Load Balancer:
    
    - Enabled by default

    - No charges for inter AZ

- Network Load Balancer:
    
    - Disabled by default

    - No charges for inter AZ

## SSL/TLS

- TLS (Transport Layer Security) is a newer version of SSL (Secure Socket Layer)

- Public SSL certificates are issued by CA

- You can manage certificates using ACM

- SNI (Server Name Indication) solves problem of loading multiple SSL certificates onto one web server (to serve multiple websites)

- Its a newer protocol and requires the client to indicate the hostname of the target server in the initial handshake. The server will then find the correct certificate, or return default one.

- CLB:
    - Support only one SSL cert

- ALB, NLB:
    - Support SNI, multiple SSL based on Security Group

## Connection Draining

- Stop sending new requests to the instance which is draining, de-registering, unhealthy.

- New connections will establish to all other instances.

## Auto Scaling Group

- Attributes:
    - A launch configuration

    - Min Size / Max Size / Initial Capacity

    - Network + Subnets information

    - Load Balancer Information

    - Scaling Policies

- Auto Scaling Alarms

    - it is possible to scale an ASG based on CloudWatch alarms

    - An alarm monitors a metric

    - Metrics are computed for the overall ASG instances

    - Scaling policies can be on CPU, Network, ... and can even be on custom metrics or based on a schedule

- Use launch configuration or launch templates

- To update ASG, you must provide a new launch configuration / launch template

- IAM roles attached to an ASG will get assigned to EC2 instances

- ASG can terminate instances marked as unhealthy by an LB (then replace them)

- Scaling Policies
    
    - Target Tracking Scaling:
        - Most simple and easy to set-up
        - Example: i want the average ASG CPU to stay at around 40%

    - Simple / Step Scaling:
        - a CloudWatch alarm is triggered (CPU > 70%), then add 2 units
        - a CloudWatch alarm is triggered (CPU < 30%), then remove 1 units
    
    - Scheduled Actions
        - Anticipate a scaling based on known usage patterns
        - Example: increase the min capacity to 10 at 5 pm on Fridays
