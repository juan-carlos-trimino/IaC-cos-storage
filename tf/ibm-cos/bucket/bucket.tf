
resource "random_string" "unique-string" {
  length = 6
  special = false
  upper = false
  number = true
  lower = true
}

module "bucket" {
  # Specify the location of the module, which contains the file main.tf.
  source = "./modules"
  resource_group_id = data.ibm_resource_group.rg.id
  plan = var.plan
  location = var.location
  bucket_name = var.bucket_name
  region_location = var.region_location
  storage_class = var.storage_class
}
