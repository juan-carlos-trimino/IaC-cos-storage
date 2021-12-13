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
  "public",
  "public"
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
  true
]
```
***
<br>

> allowed_ip (Optional, list(list(string)))

A list of (IPv4 or IPv6 addresses in CIDR format) allowed continuous non-overlapping IP address ranges for the container. If a request from a client IP that is not in this IP address list, the client request would be rejected. If not provided, bucket is allowed to be accessed from any IP address.

```
allowed_ip = [
  # [
  #   "192.168.10.0/24",
  #   "192.168.25.200/32"
  # ],
  # [
  #   "192.169.10.100/30"
  # ]
  null,
  null
]
```
***
<br>

> expire_rules (Required, list(list(object({enable = bool days = string prefix = string}))))

An expiration rule deletes objects after a defined period (from the object creation date). For more information, see [Deleting stale data with expiration rules](https://cloud.ibm.com/docs/cloud-object-storage?topic=cloud-object-storage-expiry)

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
```
***
<br>

> activities_tracking (Optional, list(list(object({activity_tracker_crn = string read_data_events = bool write_data_events = bool}))))


Object to enable auditing with IBM Cloud Activity Tracker - Optional - Configure your IBM Cloud Activity Tracker service instance and the type of events that you want to send to your service to audit activity against your bucket. For a list of supported actions, see Bucket actions.
[Bucket events](https://cloud.ibm.com/docs/cloud-object-storage?topic=cloud-object-storage-at-events#at-actions-mngt-2)

For more information, see [IBM Cloud Activity Tracker](https://cloud.ibm.com/docs/activity-tracker?topic=activity-tracker-getting-started).





```
activities_tracking = [
  [
    {
      activity_tracker_crn = ""
      read_data_events = true
      write_data_events = true
    }
  ],
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

