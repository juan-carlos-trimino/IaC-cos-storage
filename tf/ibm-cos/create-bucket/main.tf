module "bucket1" {
  # Specify the location of the module, which contains the file main.tf.
  source = "../modules/bucket"
  bucket_name = "${var.bucket_name}-${random_id.postfix-bucket[0].hex}"
  resource_group_id = data.ibm_resource_group.rg.id
  plan = var.plan
  location = var.location
  region_location = var.region_location
  storage_class = var.storage_class
}

module "bucket2" {
  # Specify the location of the module, which contains the file main.tf.
  source = "../modules/bucket"
  bucket_name = "${var.bucket_name}-${random_id.postfix-bucket[1].hex}"
  resource_group_id = data.ibm_resource_group.rg.id
  plan = var.plan
  location = var.location
  region_location = var.region_location
  storage_class = var.storage_class
}
