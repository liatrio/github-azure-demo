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

variable "sql_edition" {
  default = "GeneralPurpose"
}

variable "sql_requested_service_objective_name" {
  default = "GP_S_Gen5_1"
}

variable "sql_max_size_bytes" {
  default = 2 * 1024 * 1024 * 1024 # 2G
}