resource "random_id" "postfix-bucket" {
  count = var.bucket_count
  byte_length = 4
}
