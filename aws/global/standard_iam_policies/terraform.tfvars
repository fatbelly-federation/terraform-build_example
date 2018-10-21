terragrunt = {
  # Include all the settings from the root .tfvars file
  include {
    path = "${find_in_parent_folders()}"
  }

  # Apply the code in the consul module
  terraform {
    #source = "../../../../modules//tfm_aws_iam_policies"  # uncomment for local development
    source = "github.com/fatbelly-federation/tfm_aws_iam_policies?ref=v1.0.1"
    extra_arguments "global_vars" {
      commands = [
        "apply",
        "plan",
        "destroy",
        "refresh"
      ]

      # last match wins     
      arguments = [
        "-var-file=${get_tfvars_dir()}/../../terraform.tfvars",
        "-var-file=${get_tfvars_dir()}/terraform.tfvars",
      ]
    }
  }

  dependencies {
  }

}

# IAM roles & policies do not support Tags

# set iam policy prefix
policy_prefix = "zzz"
