# Traffic Matrix

| Source | Destination | Protocol/Port | Purpose | Decision |
|---|---|---:|---|---|
| Internet users | Public load balancer | HTTPS/443 | Access the application | Allow |
| Public load balancer | Private application | HTTP/HTTPS | Forward application requests | Allow |
| Private application | Private database | Database-specific port | Read and write application data | Allow |
| Internet users | Private application | Any direct traffic | Bypass the load balancer | Deny |
| Internet users | Private database | Any direct traffic | Prevent public database access | Deny |
| Internet users | Administrative interface | SSH/RDP | Direct administrative access | Deny |
| Application | Logging service | HTTPS/443 | Send logs and monitoring data | Allow, least privilege |

## Security assumptions

- Security groups will reference trusted source security groups where possible.
- Database access will be restricted to the application security group.
- Administrative access will use a controlled management method.
- Rules will be reviewed before Terraform deployment.