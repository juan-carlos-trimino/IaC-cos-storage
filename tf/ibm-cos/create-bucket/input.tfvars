resource_instance_name = "cos-memories-63becb27f5fa"

bucket_name_postfix = true

bucket_names = [
  "cos-bucket-memories-",
  "cos-bucket-memories-"
]

region_location = [
  "br-sao",
  "br-sao"
]

role = [
  "Writer",
  "Writer"
]

hmac = [
  true,
  false
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
