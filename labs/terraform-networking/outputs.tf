output "vpc_cidr" {
  description = "CIDR range assigned to the VPC."
  value       = aws_vpc.resilientops.cidr_block
}

output "public_subnet_id" {
  description = "ID of the public subnet."
  value       = aws_subnet.public.id
}

output "private_app_subnet_id" {
  description = "ID of the private application subnet."
  value       = aws_subnet.private_app.id
}