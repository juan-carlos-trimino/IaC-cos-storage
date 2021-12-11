############################
# DECLARE GLOBAL VARIABLES #
############################
variable bucket_names {
  description = "The name of the bucket (required)."
  type = list(string)
}

variable bucket_name_postfix {
  description = "Add unique postfix to the name of the bucket."
  type = bool
}

variable storage_class {
  description = "The storage class for the bucket (required)."
  # Supported values are: standard, vault, cold, flex, and smart.
  type = list(string)
}

variable region_location {
  description = "The location of a regional bucket."
  # Supported values are: au-syd, eu-de, eu-gb, jp-tok, us-east, us-south, ca-tor, jp-osa, br-sao.
  # If you set this parameter, do not set "single_site_location" or "cross_region_location" at the
  # same time.
  type = list(string)
}

variable plan {
  description = "The name of the plan type supported by service (required)."
  # Supported values are: lite, standard.
  type = list(string)
}

variable location {
  description = "Target location or environment to create the resource instance."
  type = list(string)
}

variable force_delete {
  description = "As the default value is true, it will delete all the objects in the COS Bucket and then delete the bucket."
  type = list(bool)
}
