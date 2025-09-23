resource "aws_dynamodb_table" "main" {
  name           = "${var.project_name}_table"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S" # S for String
  }

  
}
