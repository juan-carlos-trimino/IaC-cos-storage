resource "random_string" "unique-string" {
  length = 6
  special = false
  upper = false
  number = true
  lower = true
}
