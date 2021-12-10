/***
----------------------------------------------------
A Terraform reusable module for provisioning storage
----------------------------------------------------

Using Terraform to provision storage
------------------------------------
(1) Use Terraform to create the infrastructure in the cloud.

Use Terraform
-------------
To initialize Terraform and install the various providers.
> terraform init

To create the infrastructure.
-auto-approve - Enable automatic approval; no human intervention is required.
> terraform apply -auto-approve

To destroy the infrastructure.
> terraform destroy -auto-approve
***/

/***
Bucket names must be globally unique and DNS-compliant; names between 3 and 63 characters long must
be made of lowercase letters, numbers, and dashes. Bucket names must begin and end with a lowercase
letter or number. Bucket names resembling IP addresses are not allowed. Bucket names must be unique
because all buckets in the public cloud share a global namespace, allowing access to buckets
without the need to provide any service instance or account information. It is not possible to
create a bucket with a name beginning with "cosv1-" or "account-" as these prefixes are reserved by
the system.

Delete a bucket
A DELETE issued to an empty bucket deletes the bucket. The name of the bucket will be held in
reserve by the system for 10 minutes after the deletion. After 10 minutes the name will be released
for re-use. Only empty buckets can be deleted.

If the Object Storage service instance is deleted, all bucket names in that instance will be held
in reserve by the system for 7 days. After 7 days the names will be released for re-use.
***/
resource "ibm_cos_bucket" "cos-bucket-memories" {
  bucket_name = "${var.bucket_name}-${random_string.unique-string.result}"
  resource_instance_id = ibm_resource_instance.cos-instance-memories.id
  region_location = var.region  #Resiliency.
  storage_class = var.storage_class
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
    "HMAC" = true
  }
}

# resource "ibm_resource_key" "cos-writer-memories" {
#   name = "cos-writer-memories"
#   role = "Writer"
#   resource_instance_id = ibm_resource_instance.cos-instance-memories.id
#   parameters = {
#     HMAC : true
#   }
# }

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
