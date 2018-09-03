terragrunt = {
  # Include all the settings from the root .tfvars file
  include {
    path = "${find_in_parent_folders()}"
  }

  # Apply the code in the consul module
  terraform {
    #source = "../../../../../modules/tfm_aws_security_groups"  # uncomment for local development
    source = "github.com/fatbelly-federation/tfm_aws_security_groups?ref=v1.0.0"
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

  dependencies {
    # vpc needs to be built *before* we can create the security groups for it
    paths = ["../vpc"]
  }

}

# set some security group specific tags
tags = {
  "sg_version" = "20180901"
}

