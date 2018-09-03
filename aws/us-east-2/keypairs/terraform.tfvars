terragrunt = {
  # Include all the settings from the root .tfvars file
  include {
    path = "${find_in_parent_folders()}"
  }

  # Apply the code in the consul module
  terraform {
    #source = "../../../../terraform-modules/aws/security/keypair/" # uncomment for local development
    source = "github.com/fatbelly-federation/tfm_aws_keypair?ref=v1.0.0"
    extra_arguments "global_vars" {
      commands = [
        "apply",
        "plan",
        "destroy",
        "refresh"
      ]
     
      arguments = [
        "-var-file=${get_tfvars_dir()}//../../terraform.tfvars",
        "-var-file=${get_tfvars_dir()}//../region-common.tfvars",
      ]
    }
  }
}

# list of key_pair names
key_name_list = ["st_nick"]

# map of key_pair names to actual public keys
public_key_map  = {
    "st_nick"   = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAIEAr2vGk2QuU+RYFnGnOm6gPvctW6ehIB4bikw3/S6lEVmRWhY5oXw2cI75/mKDQZXLD+aSLOMgP/MPulVkO/iIlCB4hHYIDq+M6hgXhImVRDv3FGqO0P5lO6SVUmrJIPXQ9l1lDUvI6opMtpaXKZg4w9AMOoizzDIlojcffqzCoFU="
}

