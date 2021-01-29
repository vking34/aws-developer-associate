# Private vs Public vs Elastic IP

## Private vs Public IP

- IPv4 allows for 3.7 billion different addresses in the pulic space.

- IPv4 is still the most common format used online

- IPv6 is newer and solves problems for IPv4 and for the IoT

## Elastic IP

- When u stop and then start an EC2 instance, it can __change its public IP__, but __remains its private IP__. 

- If you need to have a fixed public IP for your instance, you need an Elastic IP

- An Elastic IP is a public IPv4 you own as long as you do not delete it

- You can attach an elastic IP to one instance at a time

- With an elastic IP address, you can mask the failure of an instance or software by rapidly remapping the address to another instance in your account.

- You can only have 5 Elastic IP in your account (you can ask AWS to increase that)

- Avoid using Elastic IP:
    - Often reflect poor architectural decisions
    - Instead, use a random public IP and register a DNS name to it. It is much more in control and more scalable
    - Using load balancer is the best pattern 


