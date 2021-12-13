############################
# DECLARE GLOBAL VARIABLES #
############################
variable bucket_name_postfix {
  type = bool
}

variable bucket_names {
  type = list(string)
}

variable storage_class {
  type = list(string)
}

variable region_location {
  type = list(string)
}

variable endpoint_type {
  type = list(string)
}

variable force_delete {
  type = list(bool)
}

variable allowed_ip {
  type = list(list(string))
}

variable expire_rules {
  type = list(list(object({
    enable = bool
    days = string
    prefix = string
  })))
}

variable activities_tracking {
  type = list(list(object({
    activity_tracker_crn = string
    read_data_events = bool
    write_data_events = bool
  })))
}




variable metrics_monitoring {
  description = "Enable metrics tracking with IBM Cloud Monitoring."
  type = list(object({
    metrics_monitoring_crn = string
    request_metrics_enabled = bool
    usage_metrics_enabled = bool
  }))
}

variable archive_rules {
  description = "Archive is available in certain regions only."
  type = list(object({
    enable = bool
    days = number
    type = string
  }))
}




variable plan {
  type = list(string)
}




variable location {
  type = list(string)
}


