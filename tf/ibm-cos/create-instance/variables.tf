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
  default = []
}

variable plan {
  type = list(string)
  default = []
}

variable location {
  type = list(string)
  default = []
}

variable create_timeout {
  type = list(string)
  default = []
}

variable update_timeout {
  type = list(string)
  default = []
}

variable delete_timeout {
  type = list(string)
  default = []
}
