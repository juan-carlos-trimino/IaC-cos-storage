resource_instance_name = "cos-memories-dc8e33b8fa6c"

bucket_name_postfix = true

bucket_names = [
  "cos-bucket-memories-",
  "cos-bucket-memories-"
]

region_location = [
  "us-south",
  "br-sao"
]

role = [
  "Manager",
  "Manager"
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
