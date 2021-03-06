# CLI + SDK


## CLI



## SDK

- Coding against AWS services such as DynamoDB

- The exam expects you to know when you should use an SDK

- If you don not specify or configure a default region, then __us-east-1 will be chosen by default__


## AWS Limits

- API Rate Limits

    - DescribeInstances API for EC2 has a limit of 100 calls per seconds
    - GetObject on S3 has a limit of 5500 GET per second per prefix
    - For intermittent Errors: implement Exponential Backoff
    - For Consistent Errors: request an API throttling limit increase

- Service Quotas (Services limits) 
    - Running On-Demand Standard instances: 1152 vCPU
    - You can request a service limit increase by opening a ticket
    - You can request a service quota increase by using the Service Quotas API


- Exponential Backoff
    - If you get ThrottlingException intermittently, use exponential backoff
    - Retry mechanism included in SDK API calls
    - Must implement yourself if using the API as is or in specific cases

    ![](../references/images/sdk-00.png)

## Credentials

## Credentials Provider Chain

- CLI Credentials Provider Chain:
    
    - Command line options: --region, --output, and --profile

    - Environment variables: AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, and AWS_SESSION_TOKEN

    - CLI credentials file: ~/.aws/credentials

    - CLI credential configuration file: ~/.aws/config

    - Container credentials: for ECS tasks

    - Instance profile credentials: for EC2 instance

- SDK Credentials Provider Chain:
    - Environment variables

    - Java system properties

    - The default credential profiles

    - ECS container credentials

    - Instance profile credentials

## Best practices

- If using working within AWS, use IAM roles:
    - EC2 instances roles

    - ECS roles

    - Lambda roles

- If working outside of AWS, use environment variables / names profiles
