terragrunt = {
  # Include all the settings from the root .tfvars file
  include {
    path = "${find_in_parent_folders()}"
  }

  terraform {
    #source = "../../../../../modules//tfm_aws_route53/toplevel_domain" # uncomment for local development
    source = "github.com/fatbelly-federation/tfm_aws_route53//toplevel_domain"
    extra_arguments "global_vars" {
      commands = [
        "apply",
        "plan",
        "destroy",
        "refresh"
      ]
     
      arguments = [
        "-var-file=${get_tfvars_dir()}/../../../terraform.tfvars",
      ]
    }
  }
}

# add the domain zaxxon.pw to route53
toplevel_domain = "zaxxon.pw"
