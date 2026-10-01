# ResilientOps

Secure hybrid migration and Terraform-managed AWS recovery platform.

## Purpose

ResilientOps models a small business migrating an internal application from an Ubuntu server to AWS. The platform will demonstrate secure architecture, infrastructure as code, monitoring, incident response, and recovery while remaining cost-conscious.

## Releases

1. **Hybrid migration:** local Dockerised workload, current-state analysis, target design, and migration plan.
2. **Terraform and DevSecOps:** repeatable AWS foundation, validation, security scanning, and OIDC-based CI/CD.
3. **Security and resilience:** logging, detection, controlled remediation, backup/restore, and measured RTO/RPO.

## Working rule

Every study activity must either produce project evidence, close a knowledge gap, or improve interview articulation.

## Current status

- [x] Project scaffold created
- [ ] Local Terraform exercise
- [ ] Local Dockerised workload
- [ ] AWS target architecture
- [ ] Terraform AWS foundation
- [ ] Security and recovery tests

## Safety

- Synthetic data only.
- No `terraform apply` or `destroy` without reviewing the plan.
- Check AWS costs after every cloud lab.
- Do not commit credentials, `.tfstate` files, or secrets.

## Validation commands

```bash
terraform -chdir=labs/terraform-basics init
terraform -chdir=labs/terraform-basics fmt
terraform -chdir=labs/terraform-basics validate
terraform -chdir=labs/terraform-basics plan
```
