variable "environment" {
  default = "preview"
}

variable "branch" {
  default = "master"
}

variable "resource_group_name" {}

variable "sql_server_name" {}

variable "sql_firewall_ip_addresses" {
  type = set(string)
}

variable "ARM_SUBSCRIPTION_ID" {}
variable "ARM_CLIENT_ID" {}
variable "ARM_CLIENT_SECRET" {}
variable "ARM_TENANT_ID" {}

