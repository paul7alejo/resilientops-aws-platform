# Bootstrap stack

Creates the two things every other stack depends on:

- an encrypted, versioned, private S3 bucket for Terraform remote state
- a monthly AWS Budget with email alerts at 50% and 80% of actual spend and 100% of forecast

## Why it uses local state

The state bucket cannot store its own state before it exists. This stack keeps a local
`terraform.tfstate` (git-ignored). Everything else in ResilientOps uses the S3 backend
(see `backend.tf.example`).

## Run it

```
cd infra/bootstrap
cp terraform.tfvars.example terraform.tfvars   # then edit alert_email
terraform init
terraform plan
terraform apply
```

## Cost

The bucket holds a few kilobytes of state and the budget itself is free (the first two
budgets per account are free). Expect cents per month at most.

## Teardown

Only destroy this stack when ResilientOps is finished: empty the bucket first, then run
`terraform destroy`. The bucket refuses deletion while it contains state.
