# values are pulled in from ../terraform.tfvars
# see the readme
variable "log_bucket"                  { }
variable "log_prefix"                  { }


variable "primary_state_region" {
  description = "Primary region for state bucket"
  default = "us-east-1"
}

variable "backup_state_region" {
  description = "region for the backup bucket to reside in"
  default = "us-west-2"
}

variable "remote_state_bucket" {
  description = "Bucket in that stores the terraform state file in s3"
}

variable "remote_state_bucket_replica" {
  description = "destination bucket to receive replication"
}

variable "replica_log_bucket" {
  description = "bucket that receives logs of activity from the bucket_replica_destination"
}

variable "dynamodb_table" {
  description = "The name of the dynamodb table used for locking"
}

