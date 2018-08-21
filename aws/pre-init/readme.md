This will initialize the primary & replica S3 buckets and dynamodb resources
for remote state tracking and lock state.

NOTE: the state of pre-init is **not** stored in the remote state.
It is kept in the local terraform.tfstate file

```
# How to use:
 terraform get
 terraform plan -var-file="../terraform.tfvars"
 terraform apply -var-file="../terraform.tfvars"
```

If you receive this error

```
provider.aws: no suitable version installed
```

You need to install the needed aws plug-in

```
terraform init
```

