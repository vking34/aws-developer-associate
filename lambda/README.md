# Lambda

## Serverless

- Serverless is a new paradigm in which developers dont have to manage servers anymore

- Serverless does not mean there are no servers ... it means u just dont manage/provision/see them

- Services:
    - Lambda
    - DynamoDB
    - Cognito
    - API Gateway
    - S3
    - SNS & SQS
    - Kinesis Data firehose
    - Aurora
    - Step functions
    - Fargate

## Lambda

- Virtual functions

- Limited by time - short executions

- Run on-demand

- Scaling is automated

- Benefits:
    - Easy pricing
        - Pay per req and compute time
    - Easy monitoring through CW
    - Easy to get more resources per functions (up to 3 GB)
    - Increasing RAM will also improve CPU and network

- Support
    - Custom Runtime API (community supported, Rust)