/**************************************************************************************************
----------------------------------------------------
A Terraform reusable module for provisioning storage
----------------------------------------------------

Using Terraform to provision storage
------------------------------------
(1) Use Terraform to create the infrastructure in the cloud.

Use Terraform
-------------
To initialize Terraform and install the various providers.
> terraform init

To create the infrastructure.
-auto-approve - Enable automatic approval; no human intervention is required.
> terraform apply -auto-approve

To destroy the infrastructure.
> terraform destroy -auto-approve
***************************************************************************************************
Input variables for the module.
**************************************************************************************************/
variable "name" {}

variable "resource_group_id" {}

variable "plan" {}

variable "location" {}

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

# IBM Cloud Object Storage resource.
resource "ibm_resource_instance" "cos-instance-memories" {
  name = var.name
  service = var.service_type
  resource_group_id = var.resource_group_id
  plan = var.plan
  location = var.location
  # Some resource types provide a special timeouts nested block argument that allows to customize
  # how long certain operations are allowed to take before being considered to have failed.
  timeouts {
    create = var.create_timeout
    update = var.update_timeout
    delete = var.delete_timeout
  }
}
