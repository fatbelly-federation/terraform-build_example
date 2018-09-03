# this is the root.tfvars for aws
# this where we set useful universal defaults

terragrunt = {

  terraform {
    # you lock/require a specific terraform version by setting the "required_version"
    # example why you might want to do that --> https://github.com/gruntwork-io/terragrunt/issues/252
    #required_version = "> 0.9.0, < 0.9.11"
  }

  # define the remote state bits here
  remote_state {
    backend = "s3"
    config {
      # bucket is the primary S3 bucket for storing remote state in
      # remember S3 bucket names *must* be DNS compliant
      # naming scheme is <account>-<provider>-<repo>
      # optionally could use <company>-<account>-<aws>-<repo>
      bucket         = "terraform-state-fatbelly-aws-build-example"

      # key defines where the state file is stored relative to the bucket
      # "path_relative_to_include()" stores the remote state file in the path
      # matching the directory that the tfvars was in
      key            = "${path_relative_to_include()}/terraform.tfstate"

      # region is where the primary S3 bucket will reside
      region         = "us-east-1"

      # enable at-rest encryption? (yes, you want this)
      encrypt        = true

      # dynamodb_table is the table used for locking (prevents folks from stepping on each other)
      dynamodb_table = "terraform_lock_table-fatbelly-aws-build-example"
    }
  }

}

#####################
##  pre-init bits  ##
#####################
# primary S3 bucket to store logs in
# follow same naming scheme as remote state
log_bucket = "terraform-logs-fatbelly-aws-build-example"
log_prefix = "tfstate"

# s3 remote state (match config above)
# these values are used both by pre-init and other modules to find the remote state
# region where the remote state bucket resides
primary_state_region    = "us-east-1"
remote_state_bucket     = "terraform-state-fatbelly-aws-build-example"
dynamodb_table          = "terraform_lock_table-fatbelly-aws-build-example"

# s3 replication of remote state buckets
remote_state_bucket_replica = "terraform-state-fatbelly-aws-build-example-replica"
replica_log_bucket          = "terraform-logs-fatbelly-aws-build-example-replica"
backup_state_region         = "us-west-2"


##########################
##  Universal defaults  ##
##########################

# This sets some useful defaults
# we can over-ride these in lower level tfvars

# default region
# this should be set in the region.tfvars
# we set it here as a fail-safe
region = "us-east-1"

# try apply at least these tags
# this variable will be combined with lower-level tags defines
# e.g. tags defined within us-east-2/region-common.tfvars
tags = {
  # useful billing codes to should be applied to everything
  "billing_project"     = "build_example"
  "billing_account"     = "aws_fb_12345"
  # useful reference tag to pointing the repo used to build out this environment
  "build_url"           = "https://github.com/fatbelly-federation/terraform-build_example"
  # lower level tfvars will set proper values for these tags
  # if they are missing, the default values here are easy to spot in a terragrunt plan
  "tfm_module"          = "!!! MISSING !!! ADD URL !!!"
  "tfm_module_version"  = "!!! MISSING !!! ADD MODULE VERSION !!!"
  "build_date"          = "!!! MISSING !!! ADD DATE !!! YYYY-MMM-DD e.g. 2018-Sep-03 !!!"
  "build_path"          = "!!! MISSING !!! ADD DIR PATH !!!"
}
