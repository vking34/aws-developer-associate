# API Gateway

## Integrations High Level

    - Lambda function
        - Invoke Lambda function

        - Easy way to expose REST API backed by AWS Lambda

    - HTTP:
        - Expose HTTP endpoints in backend

        - Add rate limiting, caching, user authentications, API keys, etc, ...

    - AWS Service
        
        - Expose any AWS API through the API Gateway

        - Ex: Start an AWS step function workflow, post a message to SQS

        - Add authen, deploy publicly, rate control,...

## Endpoint Types

- Edge-Optimized (default): For global clients

    - Requests are routed through the CloudFront Edge localtions (improves latency)

    - The API Gateway still lives in only one region

- Regional:
    - For clients within the same region
    - Cloud manually combine with CloudFront (more control over the caching strategies and the distribution)

- Private:
    - Can only be accessed from you VPC using an interface VPC endpoint (ENI)
    - Use a resource policy to define access

## Deployment Stages

- Make a deployment for changes to be in effect

- Changes are deployed to stages

- Each stage has its own configuration params

- Stages can be rolled back as a history of deployment is kept


## Stage Variables

- Stage variables are like env variables for API Gateway

- Use them to change often changing configuration values

- Use cases:
    - Config HTTP endpoints your stages talk to
    - Pass config params to AWS lambda through mapping templates

- Stage variable config params to AWS lambda through mapping templates

- Stage variables are passed to the context object in Lambda

- Common pattern:
    - Create a stage variable to indicate the corresponding Lambda alias
    - API Gateway will automatically invoke the right Lambda func
    ![](../references/images/api-gateway-00.png)