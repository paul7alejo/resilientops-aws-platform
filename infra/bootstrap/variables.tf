variable "region" {
  description = "AWS region for the state bucket and project."
  type        = string
  default     = "ap-southeast-2" # Sydney
}

variable "alert_email" {
  description = "Email that receives budget alerts. Set in terraform.tfvars (git-ignored), never commit it."
  type        = string
}

variable "monthly_budget_usd" {
  description = "Monthly cost budget in USD. Alerts fire at 50% and 80% of actual spend and 100% of forecast."
  type        = number
  default     = 10
}
