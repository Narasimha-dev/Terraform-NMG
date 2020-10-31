resource "aws_vpc" "vpc" {
    count		 = var.create_vpc ? 1 : 0
    cidr_block		 = var.vpc_cidr
    instance_tenancy	 = "default"
    enable_dns_support	 = "true"
    enable_dns_hostnames = "true"
    enable_classiclink	 = "false"
    tags = merge(
    	var.additional_tags,
    	{
    	  Name = "NMG-VPC"
    	},
    )
}

# Public
resource "aws_subnet" "sub_pub1" {
    count 			= var.sub_pub1_cidr == "" ? 0 : 1
    vpc_id 			= length(aws_vpc.vpc) > 0 ? aws_vpc.vpc[0].id : var.vpc_id
    cidr_block 			= var.sub_pub1_cidr
    map_public_ip_on_launch	= "true"
    availability_zone 		= "${var.region}a"
    tags = merge(
	var.additional_tags,
	{
	    Name = "${var.tag}-PUB-SUBNET1"
	},
    )
}

resource "aws_subnet" "sub_pub2" {
    count 			= var.sub_pub2_cidr == "" ? 0 : 1
    vpc_id 			= length(aws_vpc.vpc) > 0 ? aws_vpc.vpc[0].id : var.vpc_id
    cidr_block 			= var.sub_pub2_cidr
    map_public_ip_on_launch 	= "true"
    availability_zone 		= "${var.region}b"
    tags = merge(
	var.additional_tags,
	{
    	    Name = "${var.tag}-PUB-SUBNET2"
	},
    )
}

# Internet GW
resource "aws_internet_gateway" "igw" {
    vpc_id 	= length(aws_vpc.vpc) > 0 ? aws_vpc.vpc[0].id : var.vpc_id
    tags 	= merge(
	var.additional_tags,
	{
	    Name = "${var.tag}-INTERNETGATEWAY"
	},
    )
}

# route tables
resource "aws_route_table" "rt_pub" {
    vpc_id 	= length(aws_vpc.vpc) > 0 ? aws_vpc.vpc[0].id : var.vpc_id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags 	= merge(
	var.additional_tags,
	{
       	    Name = "${var.tag}-ROUTE-PUBLIC"
	},
    )
}

# route associations public
resource "aws_route_table_association" "rt_pub1" {
    count		= var.sub_pub1_cidr == "" ? 0 : 1
    subnet_id 		= length(aws_subnet.sub_pub1) > 0 ? aws_subnet.sub_pub1[0].id : ""
    route_table_id 	= aws_route_table.rt_pub.id
}
resource "aws_route_table_association" "rt_pub2" {
    count		= var.sub_pub2_cidr == "" ? 0 : 1
    subnet_id 		= length(aws_subnet.sub_pub2) > 0 ? aws_subnet.sub_pub2[0].id : ""
    route_table_id 	= aws_route_table.rt_pub.id
}

#private subnets
resource "aws_subnet" "sub_prv1" {
    count	  		= var.sub_prv1_cidr == "" ? 0 : 1
    vpc_id			= length(aws_vpc.vpc) > 0 ? aws_vpc.vpc[0].id : var.vpc_id
    cidr_block			= var.sub_prv1_cidr
    map_public_ip_on_launch 	= "false"
    availability_zone 		= "${var.region}a"
    tags 	= merge(
	var.additional_tags,
	{
	    Name = "${var.tag}-PVT-SUBNET1"
	},
    )
}

resource "aws_subnet" "sub_prv2" {
    count             	    	= var.sub_prv2_cidr == "" ? 0 : 1
    vpc_id 		    	= length(aws_vpc.vpc) > 0 ? aws_vpc.vpc[0].id : var.vpc_id
    cidr_block 		    	= var.sub_prv2_cidr
    map_public_ip_on_launch 	= "false"
    availability_zone 	    	= "${var.region}b"
    tags 	= merge(
	var.additional_tags,
        {
	    Name = "${var.tag}-PVT-SUBNET2"
        },
    )
}

resource "aws_eip" "eip" {
    vpc      = true
}

resource "aws_nat_gateway" "nat_gw" {
    allocation_id 	= "${aws_eip.eip.id}"
    subnet_id 		= length(aws_subnet.sub_pub1) > 0 ? aws_subnet.sub_pub1[0].id : ""
    depends_on 		= [aws_internet_gateway.igw]
    tags 	= merge(
   	var.additional_tags,
	{
	    Name = "${var.tag}-NAT-GATEWAY"
	},
    )
}

# VPC setup for NAT
resource "aws_route_table" "rt_prv" {
    vpc_id	  	= length(aws_vpc.vpc) > 0 ? aws_vpc.vpc[0].id : var.vpc_id
    route {
        cidr_block 	= "0.0.0.0/0"
        nat_gateway_id 	= "${aws_nat_gateway.nat_gw.id}"
    }
    tags   = merge(
	var.additional_tags,
	{
	   Name = "${var.tag}-PVT-ROUTE"
	},
    )
}

#routetable assosciation
resource "aws_route_table_association" "rt_prv1" {
    count		= var.sub_prv1_cidr == "" ? 0 : 1
    subnet_id 		= length(aws_subnet.sub_prv1) > 0 ? aws_subnet.sub_prv1[0].id : ""
    route_table_id 	= aws_route_table.rt_prv.id
}

resource "aws_route_table_association" "rt_prv2" {
    count		= var.sub_prv2_cidr == "" ? 0 : 1
    subnet_id 		= length(aws_subnet.sub_prv2) > 0 ? aws_subnet.sub_prv2[0].id : ""
    route_table_id 	= aws_route_table.rt_prv.id
}
