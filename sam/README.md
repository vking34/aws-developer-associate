# SAM - Serverless Application Model

- All the config is YAML code

- Generate complex CloudFormation from simple SAM YAML file

- SAM can use COdeDeploy to deploy Lambda func

- SAM can help you to run Lambda, API Gateway, DynamoDB locally

## Recipe

- Transform Header indicates its SAM templates:
    - Transform: `'AWS::Serverless-2016-10-31'`

- Write code:
    - `AWS::Serverless::Function`
    - `AWS::Serverless::Api`
    - `AWS::Serverless::SimpleTable`

- Package & Deploy

    - `aws cloudformation package / sam package`
    - `aws cloudformation deploy / sam deploy`