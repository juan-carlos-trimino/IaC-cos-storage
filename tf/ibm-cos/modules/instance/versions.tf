###################################################################################################
# https://registry.terraform.io/browse/providers                                                  #
###################################################################################################
# The ~> operator is a convenient shorthand for allowing only patch releases within a specific    #
# minor release.                                                                                  #
###################################################################################################
terraform {
  # Terraform version.
  required_version = ">= 1.0.0"
  required_providers {
    ibm = {
      source = "ibm-cloud/ibm"
      version = ">= 1.30.2"
    }
  }
}
