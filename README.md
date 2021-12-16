# Creation/Deletion of IBM Cloud Object Storage (COS) instances

## [Deleting an instance](https://cloud.ibm.com/docs/cloud-object-storage/basics?topic=cloud-object-storage-provision)

<br>

## Using Terraform to provision storage
#### `Note`
To install Terraform, [download](https://www.terraform.io/downloads.html) the binary executable for the Operating System (OS) being used to a directory in the system’s PATH environment variable. To verify the installation, execute the following command from a terminal.
> terraform --version

<br>

To initialize Terraform and install the various providers.
> terraform init

To create a plan for review (no resources are actually provisioned).
> terraform plan -var-file="./input.tfvars"

To create the infrastructure.
> terraform apply -var-file="./input.tfvars" -auto-approve

To destroy the infrastructure.
> terraform destroy -var-file="./input.tfvars" -auto-approve

***
***
<br>

> instance_name_postfix (Required, bool)

If set to true, a unique string will be appended to the instance name.

***
<br>

> instance_names (Required, list(string))

An instance is created/deleted for each entry in the list.

```
instance_names = [
  "cos-memories1-",
  "cos-memories2-"
]
```
***
<br>

> service_type (Required, list(string))

The name of the service offering. The default is `cloud-object-storage`.

```
service = [
  "cloud-object-storage",
  "cloud-object-storage"
]
```
***
<br>

> plan (Required, list(string))

The name of the plan type supported by service. Supported plans are: `lite` (default) and `standard`.

```
plan = [
  "lite",
  "standard"
]
```
***
<br>

> location (Required, list(string))

Target location or environment to create the resource instance. The default is `global`.

```
location = [
  "global",
  "global"
]
```
***
<br>

#### `Note`
Some resource types provide a special timeouts nested block argument that allows to customize how long certain operations are allowed to take before being considered to have failed.

<br>

> create_timeout (Optional, list(string))

Used for Creating Instance (default `10 minutes`).

```
create_timeout = [
  "10m",
  "15m"
]
```
<br>

> update_timeout (Optional, list(string))

Used for Updating Instance (default `10 minutes`).

```
update_timeout = [
  "10m",
  "15m"
]
```
<br>

> delete_timeout (Optional, list(string))

Used for Deleting Instance (default `10 minutes`).

```
delete_timeout = [
  "10m",
  "15m"
]
```
***
<br>

# Creation/Deletion of IBM Cloud Object Storage (COS) buckets

To create one or more buckets, open the file **input.tfvars** and set the appropriate parameters to the desired values. Please note that some parameters are required while others are optional. Once the file **input.tfvars** is set, execute the appropriate command. For more information about the parameters, see [ibm_cos_bucket](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cos_bucket#region_location).

#### `Note`
Before creating a bucket, an IBM COS instance must be provisioned.

***
***
<br>

> resource_instance_name (Required, string)

The name of the instance to be used for bucket creation.

***
<br>

> bucket_name_postfix (Required, bool)

If set to true, a unique string will be appended to the bucket name. Since 
*all buckets in all regions across the globe share a single namespace*, a common approach to ensure uniqueness is to append a UUID suffix to bucket names.

***
<br>

> bucket_names (Required, list(string))

A bucket is created/deleted for each entry in the list.

#### `Note`
Bucket names *must be globally unique and DNS-compliant*; names between 3 and 63 characters long must be made of lowercase letters, numbers, and dashes. Bucket names must begin and end with a lowercase letter or number. Bucket names resembling IP addresses are not allowed. Bucket names must be unique because all buckets in the public cloud share a global namespace, allowing access to buckets without the need to provide any service instance or account information. It is not possible to create a bucket with a name beginning with **cosv1-** or **account-** as these prefixes are reserved by the system.

```
bucket_names = [
  "cos-bucket-",
  "cos-bucket-"
]
```
***
<br>

> storage_class (Required, list(string))

The storage class for the bucket. For more information, see [Use storage classes](https://cloud.ibm.com/docs/cloud-object-storage?topic=cloud-object-storage-classes). The default value is `smart`.

```
storage_class = [
  "smart",
  "standard"
]
```
***
<br>

#### `Note`
Select the desired [**level of resiliency**](https://cloud.ibm.com/docs/cloud-object-storage/basics?topic=cloud-object-storage-endpoints). Then, select a *location* where the data will be physically stored. Resiliency refers to the scope and scale of the geographic area across which the data is distributed. *Cross Region* resiliency spreads the data across several metropolitan areas, *Regional* resiliency spreads the data across a single metropolitan area, and a *Single Data Center* distributes the data across devices within a single site only.

<br>

> region_location (Optional, list(string))

The location of a regional bucket. Supported values are: `au-syd`, `eu-de`, `eu-gb`, `jp-tok`, `us-east`, `us-south`, `ca-tor`, `jp-osa`, and `br-sao`. If this parameter is used, do not set `single_site_location` or `cross_region_location` at the same time. The default value is `null`.

```
region_location = [
  "us-south",
  "br-sao"
]
```
<br>

> cross_region_location (Optional, list(string))

The cross-regional bucket location. Supported values are: `us`, `eu`, and `ap`. If this parameter is used, do not set `single_site_location` or `region_location` at the same time. The default value is `null`.

```
cross_region_location = [
  "us",
  "eu"
]
```
<br>

> single_site_location (Optional, list(string))

The location for a single site bucket. Supported values are: `ams03`, `che01`, `hkg02`, `mel01`, `mex01`, `mil01`, `mon01`, `osl01`, `par01`, `sjc04`, `sao01`, `seo01`, `sng01`, and `tor01`. If this parameter is used, do not set `region_location` or `cross_region_location` at the same time. The default value is `null`.

```
single_site_location = [
  "ams03",
  "tor01"
]
```
***
<br>

> role (Required, list(string))

The name of the user role. Valid roles are: `Writer`, `Reader`, `Manager`, `Administrator`, `Operator`, `Viewer`, and `Editor`.

Capitalization matters for the roles.



https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/resource_key


https://cloud.ibm.com/docs/account?topic=account-custom-roles




The ibm_resource_key provides the following Timeouts configuration options:

create - (Default 10 minutes) Used for Creating Key.
delete - (Default 10 minutes) Used for Deleting Key.


https://cloud.ibm.com/docs/account?topic=account-iam-service-roles-actions

crn - (String) The full Cloud Resource Name (CRN) associated with the key.
  parameters = {
     HMAC: true
  }

  https://cloud.ibm.com/docs/cloud-object-storage?topic=cloud-object-storage-uhc-hmac-credentials-main






> endpoint_type (Optional, list(string))

The type of endpoint (`public` (default), `private`, or `direct`) to be used for buckets. A bucket's resiliency is defined by the endpoint used to create it. For more information, see [Endpoints and storage locations](https://cloud.ibm.com/docs/cloud-object-storage?topic=cloud-object-storage-endpoints#endpoints)

```
endpoint_type = [
  "private",
  "public"
]
```
***
<br>

> force_delete (Optional, list(bool))

If set to `true` (default), all objects in the bucket will be deleted. Since only empty buckets can be deleted, then the bucket will be deleted.

#### `Note`
force_delete will timeout on buckets with a large amount of objects. Twenty-four (24) hours before deleting the bucket, set an expire rule to remove all files over a day old.

```
force_delete = [
  false,
  true
]
```
***
<br>

> allowed_ip (Optional, list(list(string)))

A list of (IPv4 or IPv6 addresses in CIDR format) allowed continuous non-overlapping IP address ranges for the container. If a request from a client IP that is not in this IP address list, the client request would be rejected. If not provided, the bucket is allowed to be accessed from any IP address. The default value is `null`.

```
allowed_ip = [
  [
    "192.168.10.0/24",
    "192.168.25.200/32"
  ],
  [
    "192.169.10.100/30"
  ]
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

Use the IBM Cloud Activity Tracker service to track how users and applications interact with the IBM Cloud Object Storage. For more information, see [IBM Cloud Activity Tracker](https://cloud.ibm.com/docs/activity-tracker?topic=activity-tracker-getting-started). To configure the IBM Cloud Activity Tracker service instance and the type of events to send to the service to audit activity against the bucket, see [Bucket events](https://cloud.ibm.com/docs/cloud-object-storage?topic=cloud-object-storage-at-events#at-actions-mngt-2). The default value is `an empty list`.

```
activities_tracking = [
  [
    {
      activity_tracker_crn = "ibm_resource_instance.activity_tracker1.id"
      read_data_events = true
      write_data_events = true
    }
  ],
  [
    {
      activity_tracker_crn = "ibm_resource_instance.activity_tracker2.id"
      read_data_events = true
      write_data_events = true
    }
  ]
]
```
***
<br>

> metrics_monitoring (Optional, list(object({metrics_monitoring_crn = string request_metrics_enabled = bool usage_metrics_enabled = bool})))

Use the IBM Cloud Monitoring service to monitor the IBM Cloud Object Storage data in the IBM Cloud. The results of the activity can be measured for compliance and other analysis through the web dashboard UI. For more information, see [Using IBM Cloud Monitoring with IBM Cloud Object Storage](https://cloud.ibm.com/docs/cloud-object-storage?topic=cloud-object-storage-mm-cos-integration). The default value is `null`.

```
metrics_monitoring = [
  {
    metrics_monitoring_crn = "data.ibm_resource_group.cos_group1.id"
    request_metrics_enabled = false
    usage_metrics_enabled = false
  },
  {
    metrics_monitoring_crn = "data.ibm_resource_group.cos_group2.id"
    request_metrics_enabled = false
    usage_metrics_enabled = false
  }
]
```
***
<br>

> archive_rules (Optional, list(list(object({enable = bool days = number type = string}))))

IBM Cloud Object Storage "Archive" and "Accelerated Archive" are low cost options for data that is rarely accessed. For more information, see [Archiving and accessing cold data](https://cloud.ibm.com/docs/cloud-object-storage?topic=cloud-object-storage-archive). The default value is `null`.

```
archive_rules = [
  {
    enable = true
    days = 30
    type = "Glacier"
  },
  {
    enable = true
    days = 90
    type = "Accelerated"
  }
]
```
