terraform {
  required_version = ">= 1.6.0"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

resource "random_pet" "project_id" {
  prefix = var.project_prefix
  length = 2
}

resource "local_file" "project_summary" {
  filename        = "${path.module}/generated-project-summary.txt"
  content         = "ResilientOps project identifier: ${random_pet.project_id.id}\n"
  file_permission = "0644"
}

output "project_id" {
  description = "Generated identifier for this local learning exercise."
  value       = random_pet.project_id.id
}
