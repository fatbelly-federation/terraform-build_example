# How to use:
# $ terraform get
# $ terraform plan -var-file="../terraform.tfvars"
# $ terraform apply -var-file="../terraform.tfvars"

module "pre-init" {
  #source  = "../../../modules//tfm_pre-init"
  source = "github.com/fatbelly-federation/tfm_pre-init?ref=v1.1.0"

  # we read in variable values from ../terraform.tfvars
  # and use them to set values for the variables the modules is expecting
  # module is looking for "lock_table_name", we use the "dynamodb_table" variable
  # from the terraform.tfvars to set the value for "lock_table_name"
  primary_state_region       = "${var.primary_state_region}"
  backup_state_region        = "${var.backup_state_region}"
  s3_log_bucket              = "${var.log_bucket}"
  s3_state_bucket            = "${var.remote_state_bucket}"
  s3_replica_bucket          = "${var.remote_state_bucket_replica}"
  s3_replica_log_bucket      = "${var.replica_log_bucket}"
  lock_table_name            = "${var.dynamodb_table}"
  terraform_state_log_prefix = "${var.log_prefix}"

  # we configure tag values here, so that the ../terraforms.tfvars
  # can have generic values that highlight when a build is missing them
  tags = {
    "tfm_module"          = "github.com/fatbelly-federation/tfm_pre-init"
    "tfm_module_version"  = "v1.0.2"
    "build_date"          = "2018-Aug-28"
    "modified_date"       = "2018-Oct-20"
    "build_path"          = "terraform-build_example/aws/pre-init"
    "billing_account"     = "aws_fb_12345"
    "build_url"           = "https://github.com/fatbelly-federation/terraform-build_example"
  }
}

