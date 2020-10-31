variable tag {
        description = "Name of thesecurity group already concat with LoadBalancerSecurityGroup"
        default = "demo"
}

variable vpc_id {
	type	= string
	default = ""
}

variable additional_tags {
        description     = "Additional resource tags"
        type            = map(string)
        default = {
            Environment = "Production"
            Team        = "DevOps"
        }
}

