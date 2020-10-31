### terraform state file backend maintainance
# create an S3 bucket to store the state file
resource "aws_s3_bucket" "terraform-state-storage-s3" {
   bucket = var.bucket_name
   versioning {
      enabled = true
   }
   tags = merge(
    var.additional_tags,
    {
      Name = "NMG"
    },
  )
}

# create a dynamodb table for locking the state file
resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name 		= var.dynamodb_table_name
  hash_key 	= "LockID"
  read_capacity = 10
  write_capacity = 10
  attribute {
    name = "LockID"
    type = "S"
  }
  tags   = merge(
    var.additional_tags,
    {
      Name = "NMG"
    },
  )
}

