resource "random_id" "instance-name-postfix" {
  count = var.instance_name_postfix == true ? length(var.instance_names) : 0
  byte_length = 6
}
