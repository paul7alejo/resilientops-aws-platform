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

## 2026-10-03 — AWS networking foundation

### What I learned

- A VPC provides an isolated network within AWS.
- A `/16` VPC contains a much larger address range than a `/24` subnet.
- A public subnet uses a route table with a default route to an Internet Gateway.
- A private subnet does not automatically have internet access.
- Setting `map_public_ip_on_launch = true` allows resources launched in the public subnet to receive public IP addresses.
- Security groups are stateful virtual firewalls.
- Referencing another security group is safer than allowing application traffic from every IP address.
- `terraform plan` previews infrastructure without creating AWS resources.

### What I built

- VPC using the `10.20.0.0/16` CIDR range.
- Public subnet using `10.20.1.0/24`.
- Private application subnet using `10.20.10.0/24`.
- Internet Gateway and public route table.
- Public subnet route-table association.
- ALB security group allowing HTTPS on port 443 from the internet.
- Application security group allowing port 8080 only from the ALB security group.
- Terraform outputs for the VPC and subnet information.

### Terraform plan result

Terraform proposed eight resources:

1. One VPC.
2. Two subnets.
3. One Internet Gateway.
4. One public route table.
5. One route-table association.
6. Two security groups.

Plan result: `8 to add, 0 to change, 0 to destroy`.

No AWS resources were applied. The configuration was validated and reviewed using `terraform plan` only.

### Questions to revisit

- How does a NAT Gateway provide outbound internet access to private resources?
- Why should production workloads use multiple Availability Zones?
- How should security-group rules be separated as the architecture grows?
- How should Terraform state be stored and protected for team environments?