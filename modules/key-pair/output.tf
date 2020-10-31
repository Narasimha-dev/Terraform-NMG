output id {
	description	= "The key pair name"
	value		= aws_key_pair.main.id
}

output key_name {
        description     = "The key pair name"
	value           = aws_key_pair.main.key_name
}

output arn {
        description     = "The key pair ARN"
	value           = aws_key_pair.main.arn
}

output key_pair_id {
        description     = "The key pair ID"
	value           = aws_key_pair.main.key_pair_id
}


