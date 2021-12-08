resource "ibm_resource_instance" "cos-instance-memories" {
  name = "cos-instance-memories"
  service = "cloud-object-storage"
  resource_group_id = data.ibm_resource_group.rg.id
  plan = var.plan
  location = var.location
}

/***
Bucket names must be unique because all buckets in the public cloud share a global namespace. This
allows for access to a bucket without needing to provide any service instance or account
information. It is also not possible to create a bucket with a name beginning with cosv1- or
account- as these prefixes are reserved by the system.

Delete a bucket
A DELETE issued to an empty bucket deletes the bucket. The name of the bucket will be held in
reserve by the system for 10 minutes after the deletion. After 10 minutes the name will be released
for re-use. Only empty buckets can be deleted.

If the Object Storage service instance is deleted, all bucket names in that instance will be held
in reserve by the system for 7 days. After 7 days the names will be released for re-use.
***/
resource "ibm_cos_bucket" "cos-bucket-memories" {
  bucket_name = var.bucket_name
  resource_instance_id = ibm_resource_instance.cos-instance-memories.id
  region_location = var.region  #Resiliency.
  storage_class = "smart"
  expire_rule {
    rule_id = "cos-expire-rule-memories"
    enable = true
    days = 30
  }
}

resource "ibm_resource_key" "cos-manager-memories" {
  name = "cos-manager-memories"
  role = "Manager"
  resource_instance_id = ibm_resource_instance.cos-instance-memories.id
  parameters = {
    # "HMAC" = true
    HMAC : true
  }
}

resource "ibm_resource_key" "cos-writer-memories" {
  name = "cos-writer-memories"
  role = "Writer"
  resource_instance_id = ibm_resource_instance.cos-instance-memories.id
  parameters = {
    HMAC : true
  }
}

# output "bucket_private_endpoint" {
#   value = ibm_cos_bucket.cos-bucket-memories.s3_endpoint_private
# }

# output "bucket_public_endpoint" {
#   value = ibm_cos_bucket.cos-bucket-memories.s3_endpoint_public
# }

# output "cos-bucket-xx-key-jct" {
#   value = ibm_resource_key.resourceKey
#   sensitive = false
# }
