output "vpc_cidr" {
  description = "CIDR range assigned to the VPC."
  value       = aws_vpc.resilientops.cidr_block
}
