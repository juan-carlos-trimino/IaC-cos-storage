/***
Input variables for the module.
***/
variable "resource_group_id" {}

variable "plan" {}

variable "location" {}

variable "bucket_name" {}

variable "region_location" {}

variable "storage_class" {}

variable "service_type" {
  default = "cloud-object-storage"
}

variable "create_timeout" {
  description = "(Default 10 minutes) Used for Creating Instance."
  default = "10m"
}

variable "update_timeout" {
  description = "(Default 10 minutes) Used for Updating Instance."
  default = "10m"
}

variable "delete_timeout" {
  description = "(Default 10 minutes) Used for Deleting Instance."
  default = "10m"
}
