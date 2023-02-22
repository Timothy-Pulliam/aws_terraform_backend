variable "bucket_name" {
    type = string
    description = "Bucket name where the Terraform state file will be stored"
    default = "tfmstate12345"
}