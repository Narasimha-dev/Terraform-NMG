resource "aws_security_group" "main" {
	name        = "${var.tag}-SecurityGroup"
	description = "${var.tag}-WebAppSecurityGroup"
	vpc_id 	    = var.vpc_id
	ingress {
		protocol 	= "tcp"
		from_port 	= 80
		to_port 	= 80
		cidr_blocks 	= ["0.0.0.0/0"]
	}
	ingress {
                protocol 	= "tcp"
                from_port 	= 22
                to_port 	= 22
                cidr_blocks 	= ["0.0.0.0/0"]
        }
	egress {
		protocol 	= "-1"
		from_port 	= 0
		to_port 	= 0
		cidr_blocks 	= ["0.0.0.0/0"]
	}
	tags 	= merge(
		var.additional_tags,
		{
			Name = "${var.tag}-WebAppSecurityGroup"
		},
	)
}
