resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "flight-data"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "Id"
  range_key      = "airline"

  attribute {
    name = "Id"
    type = "S"
  }

  attribute {
    name = "airline"
    type = "S"
  }

  attribute {
    name = "flightNumber"
    type = "S"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = true
  }

  global_secondary_index {
    name               = "airlineIndex"
    hash_key           = "airline"
    range_key          = "flightNumber"
    write_capacity     = 1
    read_capacity      = 1
    projection_type    = "INCLUDE"
    non_key_attributes = ["Id"]
  }

  tags = {
    Name        = "dynamodb-table-1"
    Environment = "DEV"
  }
}
