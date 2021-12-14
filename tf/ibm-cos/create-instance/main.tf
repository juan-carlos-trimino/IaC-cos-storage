module "instance" {
  # Specify the location of the module, which contains the file main.tf.
  source = "../modules/instance"
  count = length(var.instance_names)
  name = (var.instance_name_postfix ?
          "${var.instance_names[count.index]}${random_id.instance-name-postfix[count.index].hex}" :
          var.instance_names[count.index])
  resource_group_id = data.ibm_resource_group.rg.id



  plan = var.plan
  location = var.location
}
