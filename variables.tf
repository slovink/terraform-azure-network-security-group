#Module      : LABEL
#Description : Terraform label module variables.

variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "managedby" {
  type        = string
  default     = ""
  description = "managedby, slovink"
}

variable "repository" {
  type        = string
  default     = ""
  description = "Terraform current module repo"
}
variable "label_order" {
  type        = list(any)
  default     = []
  description = "Label order, e.g. sequence of application name and environment `name`,`environment`,'attribute' [`webserver`,`qa`,`devops`,`public`,] ."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the network security group."
}

variable "resource_group_location" {
  type        = string
  description = "The Location of the resource group where to create the network security group."
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from creating any resources."
}

variable "inbound_rules" {
  type        = list(map(string))
  default     = []
  description = "List of objects that represent the configuration of each inbound rule."
}

variable "outbound_rules" {
  type        = list(map(string))
  default     = []
  description = "List of objects that represent the configuration of each outbound rule."
}

variable "subnet_ids" {
  type        = list(string)
  default     = []
  description = "The ID of the Subnet. Changing this forces a new resource to be created."
}

variable "create" {
  type        = string
  default     = "30m"
  description = "Used when creating the Resource Group."
}

variable "update" {
  type        = string
  default     = "30m"
  description = "Used when updating the Resource Group."
}

variable "read" {
  type        = string
  default     = "5m"
  description = "Used when retrieving the Resource Group."
}

variable "delete" {
  type        = string
  default     = "30m"
  description = "Used when deleting the Resource Group."
}
