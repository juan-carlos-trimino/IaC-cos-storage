module "bucket" {
  # Specify the location of the module, which contains the file main.tf.
  source = "../modules/bucket"
  bucket_name = "${var.bucket_name}-${random_string.unique-string.result}"
  resource_group_id = data.ibm_resource_group.rg.id
  plan = var.plan
  location = var.location
  region_location = var.region_location
  storage_class = var.storage_class
}
