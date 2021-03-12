#!/bin/bash

#
aws dynamodb scan --table-name posts --projection-expression "user_id, content"  --region ap-southeast-1

#
aws dynamodb scan --table-name posts --filter-expression "user_id = :u" --expression-attribute-values '{ ":u": {"S":"qwewewe"}}' --region ap-southeast-1

#
