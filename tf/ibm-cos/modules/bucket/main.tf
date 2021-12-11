###################################
# Input variables for the module. #
###################################
variable "resource_group_id" {}

variable "plan" {}

variable "location" {}

variable "bucket_name" {}

variable "region_location" {}

variable "storage_class" {}

variable "force_delete" {
  type = bool
}

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

variable "expire_rules" {
  description = "An expiration rule deletes objects after a defined period (from the object creation date)."
  type = list(object({
    rule_id = string
    enable = bool
    days = string
    prefix = string
  }))
  default = []
}





data "ibm_resource_instance" "cos-instance-memories" {
  name              = "cos-memories-9f021190"
  location          = var.location
  resource_group_id = var.resource_group_id
  service           = "cloud-object-storage"
}





/***
Bucket names must be globally unique and DNS-compliant; names between 3 and 63 characters long must
be made of lowercase letters, numbers, and dashes. Bucket names must begin and end with a lowercase
letter or number. Bucket names resembling IP addresses are not allowed. Bucket names must be unique
because all buckets in the public cloud share a global namespace, allowing access to buckets
without the need to provide any service instance or account information. It is not possible to
create a bucket with a name beginning with "cosv1-" or "account-" as these prefixes are reserved by
the system.

Delete a bucket
A DELETE issued to an empty bucket deletes the bucket. The name of the bucket will be held in
reserve by the system for 10 minutes after the deletion. After 10 minutes the name will be released
for re-use. Only empty buckets can be deleted.

If the Object Storage service instance is deleted, all bucket names in that instance will be held
in reserve by the system for 7 days. After 7 days the names will be released for re-use.
***/
resource "ibm_cos_bucket" "cos-bucket-memories" {
  bucket_name = var.bucket_name
  resource_instance_id = data.ibm_resource_instance.cos-instance-memories.id
  region_location = var.region  #Resiliency.
  storage_class = var.storage_class
  force_delete = var.force_delete != null ? var.force_delete : true
  dynamic "expire_rule" {
    for_each = [for elem in var.expire_rules : {
      rule_id = elem.rule_id
      enable = lookup(elem, "enable", true)
      days = lookup(elem, "days", 180)
      prefix = lookup(elem, "prefix", "logs/")
    }]
    content {
      rule_id = expire_rule.value.rule_id
      enable = expire_rule.value.enable
      days = expire_rule.value.days
      prefix = expire_rule.value.prefix
    }
  }
}

resource "ibm_resource_key" "cos-manager-memories" {
  name = "cos-manager-memories"
  role = "Manager"
  resource_instance_id = data.ibm_resource_instance.cos-instance-memories.id
  parameters = {
    "HMAC" = true
  }
}

# resource "ibm_resource_key" "cos-writer-memories" {
#   name = "cos-writer-memories"
#   role = "Writer"
#   resource_instance_id = ibm_resource_instance.cos-instance-memories.id
#   parameters = {
#     HMAC : true
#   }
# }

# output "bucket_private_endpoint" {
#   value = ibm_cos_bucket.cos-bucket-memories.s3_endpoint_private
# }

# output "bucket_public_endpoint" {
#   value = ibm_cos_bucket.cos-bucket-memories.s3_endpoint_public
# }

# output "cos-bucket-xx-key-jct" {
#   value = ibm_resource_key.resourceKey
#   sensitive = false
# }
