module "cos-bucket" {
  # Specify the location of the module, which contains the file main.tf.
  source = "../modules/bucket"
  count = length(var.bucket_names)
  bucket_name = (var.bucket_name_postfix ?
                 "${var.bucket_names[count.index]}${random_id.bucket-name-postfix[count.index].hex}" :
                 var.bucket_names[count.index])
  resource_group_id = data.ibm_resource_group.rg.id
  resource_instance_name = var.resource_instance_name
  region_location = var.region_location[count.index]
  cross_region_location = var.cross_region_location[count.index]
  single_site_location = var.single_site_location[count.index]
  storage_class = var.storage_class[count.index]
  force_delete = var.force_delete[count.index]
  endpoint_type = var.endpoint_type[count.index]
  role = var.role[count.index]
  allowed_ip = var.allowed_ip[count.index]
  expire_rules = var.expire_rules[count.index]
  activities_tracking = var.activities_tracking[count.index]
  metrics_monitoring = var.metrics_monitoring[count.index]
  archive_rule = var.archive_rules[count.index]
}
