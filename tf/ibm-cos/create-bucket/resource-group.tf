resource "random_id" "bucket-name-postfix" {
  count = var.bucket_name_postfix == true ? length(var.bucket_names) : 0
  byte_length = 6
}
