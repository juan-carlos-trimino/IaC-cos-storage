###################################
# Input variables for the module. #
###################################
variable resource_instance_name {}

variable resource_group_id {}

variable bucket_name {}

variable region_location {}

variable cross_region_location {}

variable single_site_location {}

variable storage_class {}

variable endpoint_type {}

variable role {}

variable hmac {
  type = bool
}

variable allowed_ip {
  type = list(string)
}

variable force_delete {
  type = bool
}

variable service_type {
  default = "cloud-object-storage"
}

variable expire_rules {
  description = "An expiration rule deletes objects after a defined period (from the object creation date)."
  type = list(object({
    enable = bool
    days = string
    prefix = string
  }))
}

variable metrics_monitoring {
  description = "Enable metrics tracking with IBM Cloud Monitoring."
  type = object({
    metrics_monitoring_crn = string
    request_metrics_enabled = bool
    usage_metrics_enabled = bool
  })
}

variable activities_tracking {
  description = "The CRN of the IBM Cloud Activity Tracker service instance to send the events."
  type = list(object({
    activity_tracker_crn = string
    read_data_events = bool
    write_data_events = bool
  }))
}

variable archive_rule {
  description = "Archive is available in certain regions only."
  type = object({
    enable = bool
    days = number
    type = string
  })
}

data "ibm_resource_instance" "cos-instance" {
  name = var.resource_instance_name
}

/***
Delete a bucket
A DELETE issued to an empty bucket deletes the bucket. The name of the bucket will be held in
reserve by the system for 10 minutes after the deletion. After 10 minutes the name will be released
for re-use. Only empty buckets can be deleted.

If the Object Storage service instance is deleted, all bucket names in that instance will be held
in reserve by the system for 7 days. After 7 days the names will be released for re-use.
***/
resource "ibm_cos_bucket" "cos-bucket" {
  bucket_name = var.bucket_name
  resource_instance_id = data.ibm_resource_instance.cos-instance.id
  region_location = var.region_location  #Resiliency.
  cross_region_location = var.cross_region_location
  single_site_location = var.single_site_location
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
    for_each = [for e in var.activities_tracking: {
      activity_tracker_crn = e.activity_tracker_crn
      read_data_events = lookup(e, "read_data_events", false)
      write_data_events = lookup(e, "write_data_events", false)
    }]
    content {
      activity_tracker_crn = activity_tracking.value.activity_tracker_crn
      read_data_events = activity_tracking.value.read_data_events
      write_data_events = activity_tracking.value.write_data_events
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

resource "ibm_resource_key" "cos-key" {
  name = "${var.bucket_name}-key"
  role = var.role
  resource_instance_id = data.ibm_resource_instance.cos-instance.id
  parameters = {
    HMAC = var.hmac
  }
  timeouts {
    create = "15m"  # (Default 10 minutes) Used for Creating Key.
    delete = "15m"  # (Default 10 minutes) Used for Deleting Key.
  }
}
