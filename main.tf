module vpc {
	source 			= "./modules/vpc"
	create_vpc 		= var.create_vpc
	vpc_id			= var.vpc_id
	vpc_cidr		= var.vpc_cidr
	tag	 		= var.tag
	sub_pub1_cidr 		= var.sub_pub1_cidr 
	sub_pub2_cidr	 	= var.sub_pub2_cidr
	sub_prv1_cidr 		= var.sub_prv1_cidr
	sub_prv2_cidr 		= var.sub_prv2_cidr
	region			= var.region
	additional_tags		= var.additional_tags
}

module security-group {
	source 			= "./modules/security-group"
	tag			= var.tag
	vpc_id          	= module.vpc.vpc_id
	additional_tags         = var.additional_tags
}

module key-pair {
	source                  = "./modules/key-pair"
	key_name		= "mykey"
	PATH_TO_PUBLIC_KEY      = "mykey.pub"
}

module instance-a {
	source                  = "./modules/ec2"
	instance_count		= 1
	instance_type   	= "t2.micro"
	subnet_id       	= module.vpc.sub_pub1
	vpc_security_group_ids 	= [module.security-group.security_group_id]	
	associate_public_ip_address = true
	key_name		= module.key-pair.key_name
	file_source_path	= "script.sh"
	INSTANCE_USERNAME	= "ubuntu"
	PATH_TO_PRIVATE_KEY	= "mykey"
	additional_tags         = var.additional_tags
	root_block_device = [
    	    {
      		volume_type = "gp2"
      		volume_size = 10
    	    },
  	]
}

module instance-b {
        source                  = "./modules/ec2"
        instance_count          = 1
        instance_type           = "t2.micro"
        subnet_id               = module.vpc.sub_pub2
        vpc_security_group_ids  = [module.security-group.security_group_id]
        associate_public_ip_address = true
	key_name                = module.key-pair.key_name
        file_source_path        = "script.sh"
        INSTANCE_USERNAME       = "ubuntu"
        PATH_TO_PRIVATE_KEY     = "mykey"
	additional_tags         = var.additional_tags
        root_block_device = [
            {
                volume_type = "gp2"
                volume_size = 10
            },
        ]
}


