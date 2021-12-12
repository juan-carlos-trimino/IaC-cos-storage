###################################
# Input variables for the module. #
###################################
variable resource_group_id {}

variable plan {}

variable location {}

variable bucket_name {}

variable region_location {}

variable storage_class {}

variable endpoint_type {}

variable allowed_ip {
  type = list(string)
}

variable force_delete {
  type = bool
}

variable service_type {
  default = "cloud-object-storage"
}

variable create_timeout {
  description = "(Default 10 minutes) Used for Creating Instance."
  default = "10m"
}

variable update_timeout {
  description = "(Default 10 minutes) Used for Updating Instance."
  default = "10m"
}

variable "delete_timeout" {
  description = "(Default 10 minutes) Used for Deleting Instance."
  default = "10m"
}

variable expire_rules {
  description = "An expiration rule deletes objects after a defined period (from the object creation date)."
  type = list(object({
    enable = bool
    days = string
    prefix = string
  }))
  default = []
}

variable metrics_monitoring {
  description = "Enable metrics tracking with IBM Cloud Monitoring."
  type = object({
    metrics_monitoring_crn = string
    request_metrics_enabled = bool
    usage_metrics_enabled = bool
  })
}

variable activity_tracking {
  description = "The CRN of the IBM Cloud Activity Tracker service instance to send the events."
  type = object({
    activity_tracker_crn = string
    read_data_events = bool
    write_data_events = bool
  })
  default = null
}

variable archive_rule {
  description = "Archive is available in certain regions only."
  type = object({
    enable = bool
    days = number
    type = string
  })
  default = null
}






data "ibm_resource_instance" "cos-instance-memories" {
  name              = "cos-memories-a8eb4d25f69d"
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
  endpoint_type = var.endpoint_type != null ? var.endpoint_type : "public"
  force_delete = var.force_delete != null ? var.force_delete : true
  allowed_ip = var.allowed_ip != null ? var.allowed_ip : null
  dynamic "expire_rule" {
    for_each = [for e in var.expire_rules: {
      rule_id = "${var.bucket_name}-expire-rule-${index(var.expire_rules, e)}"
      enable = lookup(e, "enable", true)
      days = lookup(e, "days", 180)
      prefix = lookup(e, "prefix", "logs/")
    }]
    content {
      rule_id = expire_rule.value.rule_id
      enable = expire_rule.value.enable
      days = expire_rule.value.days
      prefix = expire_rule.value.prefix
    }
  }
  dynamic "metrics_monitoring" {
    for_each = (var.metrics_monitoring == null ? [] :
               (var.metrics_monitoring.metrics_monitoring_crn == null ||
                var.metrics_monitoring.metrics_monitoring_crn == "" ? [] :
                tolist([var.metrics_monitoring])))
    content {
      metrics_monitoring_crn = metrics_monitoring.value.metrics_monitoring_crn
      request_metrics_enabled = lookup(metrics_monitoring.value, "request_metrics_enabled", false)
      usage_metrics_enabled = lookup(metrics_monitoring.value, "usage_metrics_enabled", false)
    }
  }
  dynamic "activity_tracking" {
    for_each = (var.activity_tracking == null ? [] :
               (var.activity_tracking.activity_tracker_crn == null ||
                var.activity_tracking.activity_tracker_crn == "" ? [] :
                tolist([var.activity_tracking])))
    content {
      activity_tracker_crn = activity_tracking.value.activity_tracker_crn
      read_data_events = lookup(activity_tracking.value, "read_data_events", false)
      write_data_events = lookup(activity_tracking.value, "write_data_events", false)
    }
  }
  dynamic "archive_rule" {
    for_each = var.archive_rule == null ? [] : tolist([var.archive_rule])
    content {
      rule_id = "${var.bucket_name}-archive-rule"
      enable = lookup(archive_rule.value, "enable", true)
      days = lookup(archive_rule.value, "days", 0)
      type = lookup(archive_rule.value, "type", "Glacier")
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
