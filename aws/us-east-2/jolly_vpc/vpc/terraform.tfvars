terragrunt = {
  # Include all the settings from the root .tfvars file
  include {
    path = "${find_in_parent_folders()}"
  }

  # Apply the code in the consul module
  terraform {
    #source = "../../../../../modules/tfm_vpc"  # uncomment for local development
    source = "github.com/fatbelly-federation/tfm_vpc?ref=v1.0.1"
    extra_arguments "global_vars" {
      commands = [
        "apply",
        "plan",
        "destroy",
        "refresh"
      ]

      # last match wins     
      arguments = [
        "-var-file=${get_tfvars_dir()}/../../../terraform.tfvars",
        "-var-file=${get_tfvars_dir()}/../../region-common.tfvars",
        "-var-file=${get_tfvars_dir()}/../vpc-common.tfvars",
        "-var-file=${get_tfvars_dir()}/terraform.tfvars",
      ]
    }
  }
}

# name of this VPC is pulled from ../vpc-common.tfvars ; the vpc_name variable
# cidr block for this VPC is also pulled from ../vpc-common.tfvars

# really sholdn't have anything or at least very few things in public subnets
# so we'll break up a single Class C network for the public subnets
public_subnets     = ["172.16.8.0/26", "172.16.8.64/26", "172.16.8.128/26", "172.16.8.192/26"]

# not planning much (less than 200 running host per AZ), so private subnets will be class Cs
private_subnets    = ["172.16.10.0/24", "172.16.11.0/24", "172.16.12.0/24", "172.16.13.0/24"]

# left over space is 172.16.9.0/24 and 172.16.14.0/23

# most Regions only have three AZs, so you could go with larger subnets
# public_cidr = 172.16.8.0/23 broken into four /25 networks (e.g. 172.16.8.0/25, 172.16.8.128/25, 172.16.9.0/25, 172.16.9.128/25)
# remaining space for private subnets three /23 networks (e.g. 172.16.10.0/23, 172.16.12.0/23, 172.16.14.0/23)

# NAT gateway is needed to allow machines in private subnets to access the internet
# https://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/vpc-nat-gateway.html
# https://aws.amazon.com/vpc/pricing/
enable_nat_gateway      = "false"
enable_dns_hostnames    = "true"
enable_dns_support      = "true"
map_public_ip_on_launch = "false"

enable_dhcp_options = true
dhcp_options_domain_name = "jolly.zaxxon.pw"

