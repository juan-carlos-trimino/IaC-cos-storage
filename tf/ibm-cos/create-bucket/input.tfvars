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

endpoint_type = [
  "s3.private.us-south.cloud-object-storage.appdomain.cloud",
  "s3.private.br-sao.cloud-object-storage.appdomain.cloud"
]

force_delete = [
  false,
  null  # Same as true.
]






allowed_ip = [
  # [
  #   "ip_address",
  #   "ip_address"
  # ],
  # [
  #   "ip_address"
  # ]
  null,
  null
]

expire_rules = [
  [
    {
      enable = true
      days = 3
      prefix = "logs/"
    },
    {
      enable = true
      days = 33
      prefix = "logs/"
    }
  ],
  [
    {
      enable = false
      days = 2
      prefix = null
    }
  ]
]

activities_tracking = [
  {
    activity_tracker_crn = ""
    read_data_events = true
    write_data_events = true
  },
  null
]

metrics_monitoring = [
  {
    metrics_monitoring_crn = ""
    request_metrics_enabled = false
    usage_metrics_enabled = false
  },
  {
    metrics_monitoring_crn = null
    request_metrics_enabled = false
    usage_metrics_enabled = false
  }
]

archive_rules = [
  {
    enable = true
    days = 30
    type = "Glacier"
  },
  {
    enable = false
    days = 30
    type = "Glacier"
  }
]





plan = [
  "lite",
  "standard"
]


location = [
  "global",
  "global"
]



