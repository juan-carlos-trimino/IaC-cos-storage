module "cos-bucket" {
  # Specify the location of the module, which contains the file main.tf.
  source = "../modules/bucket"
  count = length(var.bucket_names)
  bucket_name = (var.bucket_name_postfix ?
                 "${var.bucket_names[count.index]}${random_id.bucket-name-postfix[count.index].hex}" :
                 var.bucket_names[count.index])
  resource_group_id = data.ibm_resource_group.rg.id
  resource_instance_name = var.resource_instance_name
  region_location = (length(var.region_location) != 0 ?
                     var.region_location[count.index] : null)
  cross_region_location = (length(var.cross_region_location) != 0 ?
                           var.cross_region_location[count.index] : null)
  single_site_location = (length(var.single_site_location) != 0 ?
                          var.single_site_location[count.index] : null)
  storage_class = length(var.storage_class) != 0 ? var.storage_class[count.index] : "smart"
  force_delete = length(var.force_delete) != 0 ? var.force_delete[count.index] : true
  endpoint_type = length(var.endpoint_type) != 0 ? var.endpoint_type[count.index] : "public"
  role = var.role[count.index]
  allowed_ip = length(var.allowed_ip) != 0 ? var.allowed_ip[count.index] : null
  expire_rules = var.expire_rules[count.index]
  activities_tracking = length(var.activities_tracking) != 0 ? var.activities_tracking[count.index] : []
  metrics_monitoring = length(var.metrics_monitoring) != 0 ? var.metrics_monitoring[count.index] : null
  archive_rule = length(var.archive_rules) != 0 ? var.archive_rules[count.index] : null
}
