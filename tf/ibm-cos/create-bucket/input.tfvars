resource_instance_name = "cos-memories-a8eb4d25f69d"

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
  null,
  "br-sao"
]

cross_region_location = [
  "eu",
  null
]

single_site_location = [
  null,
  null
]

endpoint_type = [
  "public",
  "public"
]

force_delete = [
  false,
  true
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
      days = 365
      prefix = "videos/"
    }
  ],
  [
    {
      enable = false
      days = 25
      prefix = null
    }
  ]
]

activities_tracking = [
  # [
  #   {
  #     activity_tracker_crn = ""
  #     read_data_events = true
  #     write_data_events = true
  #   }
  # ],
  [],
  []
]

metrics_monitoring = [
  # {
  #   metrics_monitoring_crn = ""
  #   request_metrics_enabled = false
  #   usage_metrics_enabled = false
  # },
  # {
  #   metrics_monitoring_crn = null
  #   request_metrics_enabled = false
  #   usage_metrics_enabled = false
  # }
  null,
  null
]

archive_rules = [
  # {
  #   enable = true
  #   days = 30
  #   type = "Glacier"
  # },
  # {
  #   enable = true
  #   days = 90
  #   type = "Accelerated"
  # }
  null,
  null
]
