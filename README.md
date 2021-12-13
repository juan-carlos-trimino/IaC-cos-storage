# Creation/Deletion of IBM Cloud Object Storage (COS) buckets

To create/delete one or more buckets, open the **input.tfvars** file and set the require arguments.
For more information, see [ibm_cos_bucket](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cos_bucket#region_location).

---
**Note**

Before creating a bucket, an IBM COS instance must be provisioned.

---
<br>

> bucket_name_postfix (Required, bool)

If set to true, a unique string will be appended to the bucket name.

***
<br>

> bucket_names (Required, list(string))

A bucket is created/deleted for each entry in the list.

---
**Note**

Bucket names *must be globally unique and DNS-compliant*; names between 3 and 63 characters long must be made of lowercase letters, numbers, and dashes. Bucket names must begin and end with a lowercase letter or number. Bucket names resembling IP addresses are not allowed. Bucket names must be unique because all buckets in the public cloud share a global namespace, allowing access to buckets without the need to provide any service instance or account information. It is not possible to create a bucket with a name beginning with **cosv1-** or **account-** as these prefixes are reserved by the system.

---

```
bucket_names = [
  "cos-bucket-",
  "cos-bucket-"
]
```
***
<br>

> storage_class (Required, list(string))

The storage class for the bucket. For more information, see [Use storage classes](https://cloud.ibm.com/docs/cloud-object-storage?topic=cloud-object-storage-classes).

```
storage_class = [
  "smart",
  "smart"
]
```
***
<br>

> region_location (Optional, list(string))

The location of a regional bucket. Supported values are `au-syd`, `eu-de`, `eu-gb`, `jp-tok`, `us-east`, `us-south`, `ca-tor`, `jp-osa`, and `br-sao`. If this parameter is set, do **not** set `single_site_location` or `cross_region_location` at the same time.

```
region_location = [
  "us-south",
  "br-sao"
]
```
***
<br>

> endpoint_type (Optional, list(string))

The type of endpoint (`public` (default), `private`, or `direct`) to be used for buckets. A bucket's resiliency is defined by the endpoint used to create it. For more information, see [Endpoints and storage locations](https://cloud.ibm.com/docs/cloud-object-storage?topic=cloud-object-storage-endpoints#endpoints)

```
endpoint_type = [
  "s3.private.us-south.cloud-object-storage.appdomain.cloud",
  "s3.private.br-sao.cloud-object-storage.appdomain.cloud"
]
```
***
<br>

> force_delete (Optional, list(bool))

If set to true (default), all objects in the bucket will be deleted. Since only empty buckets can be deleted, then the bucket will be deleted.

---
**Note**

force_delete will timeout on buckets with a large amount of objects. Twenty-four (24) hours before deleting the bucket, set an expire rule to remove all files over a day old.

---

```
force_delete = [
  false,
  null  # Same as true.
]
```
***
<br>




> allowed_ip (Optional, list(list(string)))

A list of IPv4 or IPv6 addresses in CIDR notation to allow access to the IBM COS bucket.xxxx

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

