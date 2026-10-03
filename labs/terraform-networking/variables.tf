variable "aws_region" {
  description = "AWS region for the learning environment."
  type        = string
  default     = "ap-southeast-2"
}

variable "vpc_cidr" {
  description = "CIDR range for the ResilientOps VPC."
  type        = string
  default     = "10.20.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR range for the public subnet."
  type        = string
  default     = "10.20.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR range for the private application subnet."
  type        = string
  default     = "10.20.10.0/24"
}