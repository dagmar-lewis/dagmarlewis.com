resource "aws_vpc" "main_vpc" {
  cidr_block                       = "10.0.0.0/16"
  assign_generated_ipv6_cidr_block = true
  enable_dns_hostnames             = true
  tags = {
    Name = "dagmarlewis_portfolio"
  }

}


resource "aws_subnet" "private_subnet" {
  vpc_id                          = aws_vpc.main_vpc.id
  cidr_block                      = "10.0.1.0/24"
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.main_vpc.ipv6_cidr_block, 8, 1)
  assign_ipv6_address_on_creation = true
  availability_zone               = "us-east-1a"
  tags = {
    Name = "dagmarlewis_portfolio"
  }
}


resource "aws_egress_only_internet_gateway" "gw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "dagmarlewis_portfolio"
  }
}

resource "aws_route_table_association" "private_route_table_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route" "private_subnet_ipv6_route" {
  route_table_id = aws_route_table.private_route_table.id
  destination_ipv6_cidr_block = "::/0"
  egress_only_gateway_id = aws_egress_only_internet_gateway.gw.id
}

data "aws_ec2_managed_prefix_list" "cloudfront" {
  name = "com.amazonaws.global.cloudfront.origin-facing"
}

resource "aws_security_group" "allow_cloudfront_managed" {
  name        = "allow-cloudfront-managed"
  description = "Allow traffic from CloudFront (AWS managed prefix list)"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    prefix_list_ids = [data.aws_ec2_managed_prefix_list.cloudfront.id] # Referencing the managed prefix list
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
  }

  # ingress {
  #   from_port   = 443
  #   to_port     = 443
  #   protocol    = "tcp"
  #   prefix_list_ids = [data.aws_ec2_managed_prefix_list.cloudfront.id] # Referencing the managed prefix list
  # }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ec2_instance_connect_endpoint" "example" {
  subnet_id = aws_subnet.private_subnet.id
}


# sudo dnf -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
