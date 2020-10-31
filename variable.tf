variable region {
        type            = string
        description     = "AWS Region to provision resources"
        default         = "us-east-1"
}

variable access_key {
        type            = string
        description     = "AWS Account Access Key"
}

variable secret_key {
        type            = string
        description     = "AWS Account Secret Key"
}

variable create_vpc {
	type 		= bool
	default 	= true
	description	= "boolean to create vpc or not"
}

variable vpc_id {
	default 	= ""
	type            = string
	description     = "pass the VPC ID here to create resources"
}

variable vpc_cidr {
        default 	= ""
	type            = string
	description     = "CIDR Range of VPC"
}

variable tag {
        default 	= ""
	type            = string
        description     = "Common name to attach for all the created resources"
}

variable additional_tags {
        description     = "Additional resource tags"
        type            = map(string)
        default = {
            Environment = "Production"
            Team        = "DevOps"
        }
}

variable sub_pub1_cidr {
        default 	= ""
	type            = string
        description     = "CIDR Range of Public Subnet 1"
}

variable sub_pub2_cidr {
        default         = ""
        type            = string
        description     = "CIDR Range of Public Subnet 2"
}

variable sub_prv1_cidr {
        default         = ""
        type            = string
        description     = "CIDR Range of Private Subnet 1"
}

variable sub_prv2_cidr {
        default         = ""
        type            = string
        description     = "CIDR Range of Private Subnet 2"
}

