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
```

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

## 2026-10-04 — Linux foundation lab

### What I learned

- Linux services should run with a restricted identity rather than as `root`.
- File ownership and permission modes control which users can read, modify, or enter files and directories.
- A running process is not necessarily ready to accept traffic immediately.
- A service listening inside a container is not automatically exposed to the host or internet.
- Process, port, connection, and log checks provide an evidence-based troubleshooting sequence.
- Linux permissions and AWS security groups protect different layers of an application.

### What I built

- An Ubuntu 24.04 Linux environment using Colima and Docker.
- An application filesystem under `/opt/resilientops`.
- A non-interactive `resilientops` system user and group.
- Root-owned application code and configuration with restricted group access.
- Service-owned logging directories and files.
- A temporary HTTP service running as `resilientops` on TCP/8080.

### What I proved

- The service account could read its configuration.
- The service account could write application logs.
- The service account could not modify the protected configuration.
- The HTTP service returned `200 OK` on port 8080.
- Stopping the process removed the listener and caused the health check to fail.
- Restarting the process restored the listener after a short startup period.
- Container routing and DNS resolution operated successfully.
- No AWS resources were created.

### Troubleshooting sequence

1. Check whether the process exists.
2. Check whether the expected port is listening.
3. Test the application endpoint.
4. Inspect logs for evidence.
5. Restart the process.
6. Allow a startup grace period.
7. Repeat the health check.

### Questions to revisit

- How should a production service be managed with `systemd` and inspected with `journalctl`?
- How should application logs be rotated and retained?
- How should Docker and ALB health-check timing be configured?
- How should application configuration and secrets be supplied securely?