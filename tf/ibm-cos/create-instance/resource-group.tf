resource "random_id" "instance-name-postfix" {
  count = length(var.instance_names)
  byte_length = 6
}
