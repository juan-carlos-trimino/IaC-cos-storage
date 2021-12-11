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
bucket_name_postfix = true

bucket_names = [
  "cos-bucket-memories-",
  "cos-bucket-memories-"
]

storage_class = [
  "smart",
  "smart"
]

region_location = [
  "us-south",
  "br-sao"
]

plan = [
  "lite",
  "standard"
]

location = [
  "global",
  "global"
]

force_delete = [
  false,
  null
]
