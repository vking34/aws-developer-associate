# Elastic Load Balancer - ELB


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

