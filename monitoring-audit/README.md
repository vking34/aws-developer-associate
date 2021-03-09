# Monitoring & Audit

## Tools

- CloudWatch:
    - Metrics:
    - Logs:
    - Events:
    - Alarms: React in real-time to metrics / events

- X-Ray:
    - Troubleshooting application performance and errors
    - Distributed tracing of microservices
    
- CloudTrail:
    - Internal monitoring of APi calls being made
    - Audit changes to Resources by users

## CloudWatch

### Metrics

- CW provides metrics for every services in AWS

- __Metric__ is a variable to monitor (CPU utilization, network, ...)

- Metrics belong to __namespaces__

- __Dimension__ is an attribute of a metric (instance id, env, ...)

- Up to 10 dimensions per metric

- Metrics have timestamps

- Create Dashboard

- Use detailed monitoring if u want more prompt scale your ASG

- Possibility to define and send your own custom metrics to CW

- Ability to use dimesions to segment metrics
    - Instance.id
    - Env.name

- Metric resolution:
    - Standard: 1 min
    - __High Resolution__: up to 1s (__StorageResolution__ API params) - higher cost

- Use API call PutMetricData

- Use exponential backoff in case throttle errors

### Alarms

- Alarms are used to trigger notifications for any metrics

- Alarms can go to ASG, EC2 actions, SNS notifications

- Various options (sampling, %, max, min, etc, ...)

- Alarm States:
    - OK: do nothing
    - INSUFFICIENT_DATA: dont send enough data for your alarm
    - ALARM: the alarm threshold is being passed

- Period:
    - Length of time in seconds to evaluate the metric
    - High resolution custom metrics: can only choose 10s or 30s

### Logs

- App can send logs to CW using SDK

- CW can collect log from:
    - Beanstalk: collection of logs from application (env)
    - ECS: collection from containers
    - Lambda
    - VPC Flow logs
    - API Gateway
    - CloudTrail based on filter
    - CW log agents: for example on EC2
    - Route53: Log DNS

- CW logs can go to:
    - Batch exporter to S3 for archival
    - Stream to ElasticSearch cluster for further analytics

- Filter expressions

- Logs storage architecture:
    - Log group:
    - Log stream:

- Define log expiration policies (never expire, 30 days, ...)

- To send logs to CW, __make sure IAM permissions are correct!__

- Security: encryption of logs using KMS at the group level

- Logs Agent vs Unified Agent:
    - For EC2, on-premise servers
    - CW logs agent:
        - Old version
        - Only send to CW logs

    - CW unified agent:
        - Collect additional system-level metrics such as RAM, processes, disk, ram, netstat, swap space, etc, ...
        - Collect logs to send to CW logs
        - Centralized configuration using SSM paramter store
    
- Filter:
    - Usage:
        - Find a specific IP inside of log
        - Count occurrences of ERROR in your logs
        - Metric filters can be used to trigger alarms
        
    - Filter do not retroactively filter data. Filters only publish the metric data points for event that happen after the filter was created

### Events

- Schedule: Cron jobs

- Event pattern: Event rules to react to a service doing something

- Triggers to Lambda functions, SQS, SNS, ...

- CW event creates a small JSON docs to give info about the change

### EventBridge

- EventBridge is the next evolution of CloudWatch Events. EventBridge builds upon and extends CW events


- Default event bus: generated by AWS services (CW Events)

- Partner event bus: receive events from SaaS service or app (Zendesk, DataDog, Segment, Autho0, ...)

- Custom Event buses: for you own app

- Event buses can be accessed by other AWS accounts

## X-Ray

- Tracing is an end to end way to following a "request"

- Each component dealing with the request adds its own "trace"

- Tracing is made of segments (+ sub segments)

- Annotations can be added to traces to provide extra-info

- Ability to trace:
    - Every request
    - Sample request

- X-Ray security:
    - IAM
    - KMS

### Installation

1. Your code must import the X-Ray SDK

2. Install the X-Ray deamon or enable X-Ray integration
    - X-Ray deamon works as a low level UDP packet interceptor
    - Lambda / other AWS services already run the X-Ray deamon for u
    - Each app must have IAM rights to write data to X-Ray

![](../references/images/xray-00.png)

### Troubleshooting

- EC2:
    - Ensure the EC2 IAM role has proper permissions
    - Ensure the EC2 instance is running the X-Ray Deamon

- Lambda:
    - Ensure it has an IAM execution role with proper policy (AWXX-RayWriteOnlyAccess)
    - Ensure X-Ray is imported in the code

### Instrumentation

- You can modify your app code to customize and annotation the data that the SDK sends to X-Ray, using interceptor, filters, handlers, middleware,...

- Concepts:
    - Segments: each app/ service will send them
    - Subsegments: if u need more details in your segment

    - Trace: segments collected together to form an end-to-end trace
    - Sampling: decrease the amount of requests sent to X-Ray, reduce cost
    - Annotations: KeyValue pairs used to index traces and filtering
    - Metadata: KeyValue pairs, not indexed, not used for searching

- X-Deamon/agent has a config to send traces cross account:
    - correct IAM permissions
    - this allows to have central account for all your app tracing

### Sampling

- Default Rules:
    - The first request __each second__ and __5%__ of any additional requests
        - 1 request per second is the __reservoir__, ensures that at least one trace is recorded each second as long the service is serving requests
        - 5% is the __rate__ at which additional requests beyond the reservoir size are sampled

### X-Ray APIs

- Write API
    - PutTraceSegments: uploads segment docs to X-Ray
    - PutTelemetryRecords: used by X-Ray deamon to upload telemetry:
        - SegmentsReceivedCount
        - SegmentsRejectedCounts
        - BackendConnectionErrors

    - GetSampingRules: Retrieve all sampling rules
    - GetSamplingTargets & GetSampingStatisticSummaries: related to GetSampingRules
    
    - X-Ray daemon needs to have an IAM policy

- Read API

    - GetServiceGraph
    - BatchGetTraces: retrieves a list of traces specified by ID. Each trace is a collection of segment docs that originates from a single request

    - GetTraceSummaries
    - GetTraceGraph


### X-Ray with Beanstalk

- Beanstalk platform include X-Ray deamon

- You can run the deamon by setting an option in beanstalk console or with a config file (in ebextensions/xray-deamon.config)


- Make sure to give your instance profile the correct IAM permissions so that X-Ray deamon can function correctly

### X-Ray with ECS

![](../references/images/xray-01.png)


## CloudTrail

- Provide govermance, compliance and audit for AWS account

- CloudTrail is enabled by default

- Get an history of events / API calls made within AWS account by:

    - Console
    - SDK
    - CLI
    - AWS services

- Can put logs from CloudTrail into CW Logs

- __If a resource is deleted in AWS, look into CloudTrail first__!

## Summary

- CloudTrail:
    - Audit API calls made by users / services / AWS console

- CloudWatch:
    - CW Metrics over time for monitoring
    - CW Logs for storing app logs
    - CW Alarms to send notifications in case of unexpected metrics

- X-Ray:
    - Automated Trace Analysis & Centrail Service Map Visualization
    - Latency, errors and fault analysis
    - Request tracking across distributed system