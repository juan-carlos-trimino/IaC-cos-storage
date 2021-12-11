module "bucket" {
  # Specify the location of the module, which contains the file main.tf.
  source = "../modules/bucket"
  count = length(var.bucket_names)
  bucket_name = (var.bucket_name_postfix ?
              "${var.bucket_names[count.index]}${random_id.bucket-name-postfix[count.index].hex}" :
              var.bucket_names[count.index])
  resource_group_id = data.ibm_resource_group.rg.id
  plan = var.plan[count.index]
  location = var.location[count.index]
  region_location = var.region_location[count.index]
  storage_class = var.storage_class[count.index]
  force_delete = var.force_delete[count.index] != null ? var.force_delete[count.index] : true
  expire_rules = [{
    rule_id = "${var.bucket_names[count.index]}expire-rule"
    enable = true
    days = 3
    prefix = "logs/"
  }]
}
