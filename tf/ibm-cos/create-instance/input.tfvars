###################################################################################################
# ----------------------------------------------------                                            #
# A Terraform reusable module for provisioning storage                                            #
# ----------------------------------------------------                                            #
#                                                                                                 #
# Using Terraform to provision storage                                                            #
# ------------------------------------                                                            #
# (1) Use Terraform to create the infrastructure in the cloud.                                    #
#                                                                                                 #
# Use Terraform                                                                                   #
# -------------                                                                                   #
# To initialize Terraform and install the various providers.                                      #
# > terraform init                                                                                #
#                                                                                                 #
# To create the infrastructure.                                                                   #
# > terraform apply -var-file="./input.tfvars" -auto-approve                                      #
#                                                                                                 #
# To destroy the infrastructure.                                                                  #
# > terraform destroy -var-file="./input.tfvars" -auto-approve                                    #
###################################################################################################
instance_name_postfix = true

instance_names = [
  "cos-memories-",
  "cos-memories-"
]
