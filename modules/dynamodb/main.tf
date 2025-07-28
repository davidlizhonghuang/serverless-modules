variable "table_name" {}
variable "read_capacity" { default = 5 }
variable "write_capacity" { default = 5 }
variable "hash_key" { default = "id" }

resource "aws_dynamodb_table" "this" {
  name           = var.table_name
  billing_mode   = "PAY_PER_REQUEST" # No need for read/write capacity in on-demand mode
  hash_key       = var.hash_key

  attribute {
    name = var.hash_key
    type = "S"
  }
}

output "table_name" {
  value = aws_dynamodb_table.this.name
}

output "table_arn" {
  value = aws_dynamodb_table.this.arn
}
