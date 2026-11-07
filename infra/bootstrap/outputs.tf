output "state_bucket" {
  description = "Name of the S3 bucket that holds Terraform state for the other stacks."
  value       = aws_s3_bucket.state.bucket
}
