## About

Terraform uses persisted state data to keep track of the resources it manages. Most non-trivial Terraform configurations either integrate with Terraform Cloud or use a backend to store state remotely. This lets multiple people access the state data and work together on that collection of infrastructure resources.

https://developer.hashicorp.com/terraform/language/settings/backends/configuration

## First Time Configuration

Set the bucket name in the `variables.tf` file.

Run `terraform init`

The state file will be temporarily stored locally. Next, create the s3 bucket to store the state file in.

`terraform plan`

`terraform apply`

This will create:

* s3 bucket with which to store the terraform state file, with versioning and encryption enabled
* DynamoDB table to store state locking information used to prevent race conditions

Lastly, to migrate the state file from your local machine to the newly created s3 bucket, uncomment out the backend subsection of the terraform block in the `main.tf` file. Don't forget to set the bucket name.

```
backend "s3" {
   bucket         = "tfmstate12345"
   key            = "backend/terraform.tfstate"
   region         = "us-east-1"
   encrypt        = true
   kms_key_id     = "alias/terraform-bucket-key"
   dynamodb_table = "terraform-state"
 }
```

then run `terraform init` once more. Terraform will ask if you want to migrate the state file. Enter "yes"

## Security

Warning: We recommend using environment variables to supply credentials and other sensitive data. If you use -backend-config or hardcode these values directly in your configuration, Terraform will include these values in both the .terraform subdirectory and in plan files. This can leak sensitive credentials.

https://developer.hashicorp.com/terraform/language/settings/backends/configuration#credentials-and-sensitive-data



## Helpful Resources

https://technology.doximity.com/articles/terraform-s3-backend-best-practices