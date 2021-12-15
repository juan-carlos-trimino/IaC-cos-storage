############################
# DECLARE GLOBAL VARIABLES #
############################
variable instance_name_postfix {
  type = bool
}

variable instance_names {
  type = list(string)
}

variable service {
  type = list(string)
}

variable plan {
  type = list(string)
}

variable location {
  type = list(string)
}

variable create_timeout {
  type = list(string)
}

variable update_timeout {
  type = list(string)
}

variable delete_timeout {
  type = list(string)
}
