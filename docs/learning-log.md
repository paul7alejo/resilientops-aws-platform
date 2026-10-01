# Learning log

## 2026-10-01 — Project foundation

### What I learned

- A provider lets Terraform communicate with an external platform.
- A resource is something Terraform manages.
- `terraform plan` previews proposed changes without applying them.
- State records Terraform's view of managed resources and their attributes.

### What I built

- Project scaffold and documentation.
- Local-only Terraform exercise using `random` and `local` providers.

### Questions to revisit

- How should Terraform state be protected in a team environment?
- When should a resource be replaced instead of updated?
- Which AWS components should be public, private, or isolated?

## Terraform lab results

- `terraform init` installed the `random` and `local` providers.
- `terraform validate` confirmed the configuration was valid.
- `terraform plan` predicted two resources: one random identifier and one local file.
- `terraform apply` created the resources locally.
- Terraform generated the identifier `better-tadpole`.
- Terraform recorded the deployment in its state file.
- Git tracked the configuration and provider lock file.

### Key understanding

Terraform manages the desired configuration and compares it with state to determine changes.

The `local_file` resource depends on `random_pet.project_id` because its content includes the generated project ID. Terraform detects this dependency from the reference:

```hcl
random_pet.project_id.id