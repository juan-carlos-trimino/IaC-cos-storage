module "instance" {
  # Specify the location of the module, which contains the file main.tf.
  source = "../modules/instance"
  count = length(var.instance_names)
  name = (var.instance_name_postfix ?
          "${var.instance_names[count.index]}${random_id.instance-name-postfix[count.index].hex}" :
          var.instance_names[count.index])
  service = var.service[count.index]
  resource_group_id = data.ibm_resource_group.rg.id
  plan = var.plan[count.index]
  location = var.location[count.index]
  create_timeout = var.create_timeout[count.index]
  update_timeout = var.update_timeout[count.index]
  delete_timeout = var.delete_timeout[count.index]
}
