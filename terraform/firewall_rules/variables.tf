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

variable "client_secret" {}
