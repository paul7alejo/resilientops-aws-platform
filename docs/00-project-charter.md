# ResilientOps on AWS: project charter

## Goal
Design, build and document a small, resilient, secure AWS environment with Terraform, and
keep evidence of what works. It is a learning and portfolio project, built alongside the
AWS Solutions Architect Associate (SAA-C03) course.

## Scope
Built in the order the course teaches it, one component per Sunday:
IAM and cost controls, S3, a multi-AZ VPC, an EC2 application server, a database migration to
RDS, load balancing and auto scaling, network logging and endpoints, security services,
and finally a simulated on-premises network with a VPN and a staged migration.

Out of scope: production traffic, real customer data, anything that needs a paid support plan.
Containers, serverless, CDN, DynamoDB, Beanstalk and ML are studied for the exam only.

## Rules
1. **Terraform only.** Every resource is created by code. Nothing is clicked together in the console
   (CloudFormation is studied for the exam and its difference is noted in the README).
2. **Synthetic data only.** No real personal, employer or customer data, ever.
3. **Evidence over claims.** Each component gets a test and a recorded result. Never claim
   availability, recovery time or savings that were not measured.
4. **Cost control is mandatory.** A budget alert exists before anything else. Everything is tagged.
   Anything that costs money while idle is destroyed at the end of the session.
5. **One change per session.** Build only what the course has already covered that week.
6. **Keep it separate.** This project is independent of any employer or consulting work.
7. **Nothing sensitive in the repo.** No state files, tfvars, keys, account IDs or ARNs.

## Region and tooling
- Region: `ap-southeast-2` (Sydney).
- Terraform 1.10 or newer, AWS provider 6.x, remote state in S3 with native locking.

## Definition of done (per component)
- Terraform plans and applies cleanly from a fresh checkout.
- A short test shows it behaves as designed, with the result written down.
- Architecture diagram and README updated.
- Expensive resources destroyed, confirmed with a final `terraform state list` or console check.

## Weekly rhythm (Sunday 14:00 to 17:00)
30 min architecture update, 90 min Terraform, 45 min testing, 15 min documentation and teardown.
