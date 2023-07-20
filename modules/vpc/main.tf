resource "aws_vpc" "eks_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "${var.project_name}-vpc"
  }

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = {
    Name = "${var.project_name}-igw"
  }  
}

data "aws_availability_zones" "available_zones" {}

resource "aws_subnet" "pub1" {
    vpc_id = aws_vpc.eks_vpc.id
    cidr_block = var.pub1_cidr
    map_public_ip_on_launch = true
    availability_zone = data.aws_availability_zones.available_zones.names[0]
     tags = {
        Name = "pub1"
        "kubernetes.io/cluster/${var.PROJECT_NAME}" = "shared"
        "kubernetes.io/role/elb"    = 1
     }
  
}

resource "aws_subnet" "pub2" {
    vpc_id = aws_vpc.eks_vpc.id
    cidr_block = var.pub2_cidr
    map_public_ip_on_launch = true
    availability_zone = data.aws_availability_zones.available_zones.names[1]
     tags = {
        Name = "pub2"
        "kubernetes.io/cluster/${var.PROJECT_NAME}" = "shared"
        "kubernetes.io/role/elb"    = 1
     }
  
}

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.eks_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.id
    }

    tags {
        Name = "Public_RT"
    }
  
}

resource "aws_route_table_association" "Public_RT_ASSC-1" {
    subnet_id = aws_subnet.pub1.id
    route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "Public_RT_ASSC-2" {
    subnet_id = aws_subnet.pub2.id
    route_table_id = aws_route_table.public_rt.id
}

resource "aws_subnet" "priv1" {
    vpc_id = aws_vpc.eks_vpc.id
    cidr_block = var.priv1_cidr
    map_public_ip_on_launch = false
    availability_zone = data.aws_availability_zones.available_zones.names[0]
     tags = {
        Name = "priv1"
        "kubernetes.io/cluster/${var.PROJECT_NAME}" = "shared"
        "kubernetes.io/role/elb"    = 1
     }
  
}

resource "aws_subnet" "priv2" {
    vpc_id = aws_vpc.eks_vpc.id
    cidr_block = var.priv2_cidr
    map_public_ip_on_launch = false
    availability_zone = data.aws_availability_zones.available_zones.names[1]
     tags = {
        Name = "priv2"
        "kubernetes.io/cluster/${var.PROJECT_NAME}" = "shared"
        "kubernetes.io/role/elb"    = 1
     }
  
}

resource "aws_eip" "ELIP-1" {
  vpc = true

  tags {
    Name = "ELIP1"
  }
}

resource "aws_eip" "ELIP-2" {
  vpc = true

  tags {
    Name = "ELIP2"
  }
}
 resource "aws_nat_gateway" "NGW-1" {
  subnet_id = aws_subnet.pub1
  allocation_id = aws_eip.ELIP-1.id

  tags{
    Name = "NGW-1"
  }
  depends_on = [aws_internet_gateway.igw.id]
  
}

resource "aws_nat_gateway" "NGW-2" {
  subnet_id = aws_subnet.pub2
  allocation_id = aws_eip.ELIP-2.id

  tags{
    Name = "NGW-2"
  }
  depends_on = [aws_internet_gateway.igw.id]
  
}



resource "aws_route_table" "Priv-RT-1" {
   vpc_id = aws_vpc.eks_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.NGW-1.id
    }

    tags {
        Name = "Private_RT-1"
    }

  
}

resource "aws_route_table" "Priv-RT-2" {
   vpc_id = aws_vpc.eks_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.NGW-2.id
    }

    tags {
        Name = "Private_RT-2"
    }

  
}

resource "aws_route_table_association" "Priv-RT-ASSC-1" {
  subnet_id = aws_subnet.priv1.id
  route_table_id = aws_route_table.Priv-RT-1.id
}

resource "aws_route_table_association" "Priv-RT-ASSC-2" {
  subnet_id = aws_subnet.priv2.id
  route_table_id = aws_route_table.Priv-RT-2.id
}