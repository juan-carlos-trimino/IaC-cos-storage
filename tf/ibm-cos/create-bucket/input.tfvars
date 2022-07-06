resource_instance_name = "cos-memories-c7b2905e208d"

bucket_name_postfix = true

bucket_names = [
  "cos-bucket-memories-"
]

region_location = [
  "us-south"
]

role = [
  "Writer"
]

hmac = [
  false
]

expire_rules = [
  [
    {
      enable = true
      days = 30
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
