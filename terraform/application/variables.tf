variable "environment" {
  default = "preview"
}

variable "branch" {
  default = "master"
}

variable "location" {
  default = "Central US"
}

variable "service_plan_tier" {
  default = "Basic"
}

variable "service_plan_size" {
  default = "B1"
}

variable "service_app_scm_type" {
  default = "LocalGit"
}

variable "client_secret" {}
