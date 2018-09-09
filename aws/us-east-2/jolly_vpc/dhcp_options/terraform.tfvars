terragrunt = {
  # Include all the settings from the root .tfvars file
  include {
    path = "${find_in_parent_folders()}"
  }

  # Apply the code in the consul module
  terraform {
    #source = "../../../../../modules/tfm_aws_dhcp_options"  # uncomment for local development
    source = "github.com/fatbelly-federation/tfm_aws_dhcp_options?ref=v1.0.0"
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


dhcp_options_domain_name  = "jolly.zaxxon.pw"
dhcp_options_ntp_servers  = ["169.254.169.123"]

# set required tags
tags = {
  "tfm_module_version"  = "v1.0.0"
  "tfm_module"          = "github.com/fatbelly-federation/tfm_aws_dhcp_options"
  "build_date"          = "2018-Sep-08"
  "build_path"          = "terraform-build_example/aws/us-east-2/jolly_vpc/dhcp_options"
}

