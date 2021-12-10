module "instance" {
  # Specify the location of the module, which contains the file main.tf.
  source = "../modules/instance"
  name = "cos-memories-${random_string.unique-string.result}"
  resource_group_id = data.ibm_resource_group.rg.id
  plan = var.plan
  location = var.location
}
