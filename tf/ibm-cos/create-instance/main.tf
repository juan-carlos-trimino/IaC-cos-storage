module "instance" {
  # Specify the location of the module, which contains the file main.tf.
  source = "../modules/instance"
  count = length(var.instance_names)
  name = (var.instance_name_postfix ?
          "${var.instance_names[count.index]}${random_id.instance-name-postfix[count.index].hex}" :
          var.instance_names[count.index])
  service = length(var.service) != 0 ? var.service[count.index] : "cloud-object-storage"
  resource_group_id = data.ibm_resource_group.rg.id
  plan = length(var.plan) != 0 ? var.plan[count.index] : "lite"
  location = length(var.location) != 0 ? var.location[count.index] : "global"
  create_timeout = length(var.create_timeout) != 0 ? var.create_timeout[count.index] : "10m"
  update_timeout = length(var.update_timeout) != 0 ? var.update_timeout[count.index] : "10m"
  delete_timeout = length(var.delete_timeout) != 0 ? var.delete_timeout[count.index] : "10m"
}
