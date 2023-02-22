#!/bin/bash

bucketname=$1

aws s3 mb s3://${bucketname} --region us-east-1
aws s3api put-bucket-versioning --bucket ${bucketname} --versioning-configuration Status=Enabled
# block public access
aws s3api put-public-access-block \
    --bucket ${bucketname} \
    --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true"

# DynamoDB for state file locking
