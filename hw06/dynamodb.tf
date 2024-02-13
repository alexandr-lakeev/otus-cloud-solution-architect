resource "aws_dynamodb_table" "stats_table" {
  name         = "StatsTable"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "location"
  range_key    = "timestamp"

  attribute {
    name = "location"
    type = "S"
  }

  attribute {
    name = "timestamp"
    type = "N"
  }

  tags = {
      Name = "StatsTable"
  }
}
