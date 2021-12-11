resource "random_id" "bucket-name-postfix" {
  count = length(var.bucket_names)
  byte_length = 6
}
