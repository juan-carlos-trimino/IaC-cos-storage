############################
# DECLARE GLOBAL VARIABLES #
############################
variable resource_instance_name {
  type = string
}

variable bucket_name_postfix {
  type = bool
}

variable bucket_names {
  type = list(string)
}

variable storage_class {
  type = list(string)
  default = []
}

variable region_location {
  type = list(string)
  default = []
}

variable cross_region_location {
  type = list(string)
  default = []
}

variable single_site_location {
  type = list(string)
  default = []
}

variable role {
  type = list(string)
}

variable hmac {
  type = list(bool)
  default = []
}

variable endpoint_type {
  type = list(string)
  default = []
}

variable force_delete {
  type = list(bool)
  default = []
}

variable allowed_ip {
  type = list(list(string))
  default = []
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
  default = []
}

variable metrics_monitoring {
  type = list(object({
    metrics_monitoring_crn = string
    request_metrics_enabled = bool
    usage_metrics_enabled = bool
  }))
  default = []
}

variable archive_rules {
  type = list(object({
    enable = bool
    days = number
    type = string
  }))
  default = []
}
