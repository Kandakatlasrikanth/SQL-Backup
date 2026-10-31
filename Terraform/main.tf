terraform {
  required_version = "~> 1.0"
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}
locals {
  service_file_path = "E:/service.txt"
}
resource "null_resource" "service_info" {
  provisioner "local-exec" {
    interpreter = ["powershell","-noprofile", "-Command"]
    command = <<EOT
      Get-service |select Name, Status -first 5 | Out-File -FilePath ${local.service_file_path} -Encoding utf8
       EOT
  }
   triggers = {
    run = timestamp()
  }
}
output "service_info" {
  value = local.service_file_path
}