variable region {
	type            = string
        description     = "AWS Region to provision resources"
	default		= "us-east-1"
}

variable access_key {
	type            = string
        description     = "AWS Account Access Key"
}

variable secret_key {
	type            = string
        description     = "AWS Account Secret Key"
}

variable bucket_name {
	type 		= string
	description 	= "S3 Bucket Name must be unique"
}

variable additional_tags {
	description 	= "Additional resource tags"
	type        	= map(string)
	default = {
    	    Environment = "Production"
    	    Team 	= "DevOps"
 	}
}

variable dynamodb_table_name {
	type            = string
        description     = "DynamoDB Table name to maintain LockID"
}

