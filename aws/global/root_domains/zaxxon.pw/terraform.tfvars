terragrunt = {
  # Include all the settings from the root .tfvars file
  include {
    path = "${find_in_parent_folders()}"
  }

  terraform {
    #source = "../../../../../modules/tfm_aws_route53//toplevel_domain/" # uncomment for local development
    source = "github.com/fatbelly-federation/tfm_aws_route53//toplevel_domain?ref=v1.0.1"
    extra_arguments "global_vars" {
      commands = [
        "apply",
        "plan",
        "destroy",
        "refresh"
      ]
     
      arguments = [
        "-var-file=${get_tfvars_dir()}/../../../terraform.tfvars",
        "--var-file=${get_tfvars_dir()}/terraform.tfvars",
      ]
    }
  }
}

# add the domain zaxxon.pw to route53
toplevel_domain = "zaxxon.pw"

# set required tags
tags = {
  "tfm_module_version"  = "v1.0.1"
  "tfm_module"          = "github.com/fatbelly-federation/tfm_aws_route53//toplevel_domain"
  "build_date"          = "2018-Aug-30"
  "build_path"          = "terraform-build_example/aws/global/root_domains/zaxxon.pw"
}

