variable region {
        type            = string
        description     = "AWS Region to provision resources"
        default         = "us-east-1"
}


variable PATH_TO_PRIVATE_KEY {
  	default 	= "mykey"
	description     = "Private key file path location"
}

variable INSTANCE_USERNAME {
  	default = "ubuntu"
}

variable instance_count {
  	description 	= "Number of instances to launch"
  	type        	= number
  	default     	= 1
}

variable AMIS {
  	type = map(string)
  	default = {
    	    us-east-1 	= "ami-00ddb0e5626798373"
	    us-east-2   = "ami-0dd9f0e7df0f0a138"
    	    us-west-2 	= "ami-0ac73f33a1888c64a"
            eu-west-1 	= "ami-0dc8d444ee2a42d8a"
	    eu-west-2	= "ami-0e169fa5b2b2f88ae"
  	}
}

variable instance_type {
  	description	= "The type of instance to start"
  	type       	= string
}

variable subnet_id {
	description     = "The VPC Subnet ID to launch in"
        type            = string
	default     	= ""
}

variable vpc_security_group_ids {
  	description 	= "A list of security group IDs to associate with"
  	type        	= list(string)
  	default     	= null
}

variable monitoring {
  	description 	= "If true, the launched EC2 instance will have detailed monitoring enabled"
  	type        	= bool
  	default     	= false
}

variable associate_public_ip_address {
  	description 	= "If true, the EC2 instance will have associated public IP address"
  	type        	= bool
  	default     	= null
}

variable ebs_optimized {
  	description 	= "If true, the launched EC2 instance will be EBS-optimized"
  	type        	= bool
  	default     	= false
}


variable root_block_device {
  	description 	= "Customize details about the root block device of the instance. See Block Devices below for details"
  	type        	= list(map(string))
  	default     	= []
}

variable ebs_block_device {
  	description 	= "Additional EBS block devices to attach to the instance"
  	type        	= list(map(string))
  	default     	= []
}


variable ephemeral_block_device {
  	description	= "Customize Ephemeral (also known as Instance Store) volumes on the instance"
  	type        	= list(map(string))
  	default     	= []
}

variable network_interface {
  	description 	= "Customize network interfaces to be attached at instance boot time"
  	type        	= list(map(string))
  	default     	= []
}

variable file_source_path {
	description     = "The File path to execute after the instance provision"
        type            = string
        default         = "script.sh"
}

variable additional_tags {
        description     = "Additional resource tags"
        type            = map(string)
        default = {
            Environment = "Production"
            Team        = "DevOps"
        }
}

variable additional_volume_tags {
        description     = "Additional resource tags"
        type            = map(string)
        default = {
            Environment = "Production"
            Team        = "DevOps"
        }
}

variable tag {
	description     = "Name of resource tag"
	type            = string
	default		= "NMG"
}

variable key_name {
        description     = "The key name to use for the instance"
        type            = string
        default         = "mykey"
}
