# Bucket Creation
To create one or more buckets, open the **input.tfvars** file and set the require information.
To get more information for all these fields, please refer the official documentation at 

> bucket_name_postfix (bool)

If set to true, a unique string will be appended to the bucket name.

> bucket_names (list(string))

A bucket is created for each entry in the list.
```
bucket_names = [
  "cos-bucket-",
  "cos-bucket-"
]
```

> storage_class (list(string))
```
storage_class = [
  "smart",
  "smart"
]
```

> region_location (list(string))
```
region_location = [
  "us-south",
  "br-sao"
]
```

> plan (list(string))
```
plan = [
  "lite",
  "standard"
]
```

> location (list(string))
```
location = [
  "global",
  "global"
]
```

> force_delete (list(bool))
```
force_delete = [
  false,
  null
]
```

> endpoint_type (list(string))
```
endpoint_type = [
  "public",
  null
]
```

> allowed_ip (list(list(string)))
```
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
```

> expire_rules (list(list(object({\
                  enable = bool\
                  days = string\
                  prefix = string\
                })))\
               )
```
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
```

> activities_tracking ()
```
activities_tracking = [
  {
    activity_tracker_crn = ""
    read_data_events = true
    write_data_events = true
  },
  null
]
```

> metrics_monitoring ()
```
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
```

> archive_rules ()
```
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
```





