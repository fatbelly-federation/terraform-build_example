# region specific defaults
region = "us-east-2"

# apply at least these tags
# this variable will be combined with lower-level tags defines 
# e.g. tags defined within vpc/vpc-common.tfvars
tags = {
  "billing_region"  = "us-east-2"
}
