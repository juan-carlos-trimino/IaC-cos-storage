############################
# DECLARE GLOBAL VARIABLES #
############################
variable instance_name_postfix {
  description = "Add unique postfix to the name of the instance."
  type = bool
}

variable instance_names {
  description = "The name of the instance (required)."
  type = list(string)
}


