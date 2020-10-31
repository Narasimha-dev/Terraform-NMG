output s3_bucket_name {
	value = aws_s3_bucket.terraform-state-storage-s3.id
}

output bucket_domain_name {
	value = aws_s3_bucket.terraform-state-storage-s3.bucket_domain_name
}

output bucket_regional_domain_name {
	value = aws_s3_bucket.terraform-state-storage-s3.bucket_regional_domain_name
}

output hosted_zone_id {
	value = aws_s3_bucket.terraform-state-storage-s3.hosted_zone_id
}

output dynamodb_table_name {
	value = aws_dynamodb_table.dynamodb-terraform-state-lock.id
}
