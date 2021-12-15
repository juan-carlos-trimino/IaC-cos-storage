/**************************************************************************************************
Input variables for the module.
**************************************************************************************************/
variable name {}

variable service {}

variable resource_group_id {}

variable plan {}

variable location {}

variable create_timeout {}

variable update_timeout {}

variable delete_timeout {}

resource "ibm_resource_instance" "cos-instance" {
  name = var.name
  service = var.service
  resource_group_id = var.resource_group_id
  plan = var.plan
  location = var.location
  timeouts {
    create = var.create_timeout == null || var.create_timeout == "" ? "10m" : var.create_timeout
    update = var.update_timeout == null || var.update_timeout == "" ? "10m" : var.update_timeout
    delete = var.delete_timeout == null || var.delete_timeout == "" ? "10m" : var.delete_timeout
  }
}
