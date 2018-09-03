# this file contain common variables and values for the VPC

# Declare the vpc_name here to help other 
# bits know they are making changes in the right VPC
vpc_name = "jolly_vpc"

# Availability Zones for VPC and VPN
# we'll default to letting terraform pick the AZs for us
# to specify which AZs to use the vpc_azs variable to supply a list of AZs
# vpc_azs = ["us-east-1a", "us-east-1c"]

# vpc cidr
# useful IPv4 subnetting references
# http://www.opus1.com/o/notes_subnet.html
# http://www.subnet-calculator.com/
# 172.16.8.0/21 breaks down into nine class C networks
vpc_cidr_block = "172.16.8.0/21"

# apply at least these tags
# this variable will be combined with lower-level tags defines 
# e.g. tags defined within vpc/terraform.tfvars
# adding billing tags to everything will make your life easier
# when TPTB ask for a cost break-down
#
# we define a default snapshot_lifetime here but it can over-rode
# in a lower-level tfvars.
tags = {
  "vpc"               = "jolly_vpc"
  "snapshot_lifetime" = "8 days"
}

