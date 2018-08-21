# How to use:
# $ terraform get
# $ terraform plan -var-file="../terraform.tfvars"
# $ terraform apply -var-file="../terraform.tfvars"

module "pre-init" {
  #source                     = "../../../terraform-modules/aws//pre-init"
  source                     = "github.com/fatbelly-federation/terraform-modules/aws//pre-init"

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
}
