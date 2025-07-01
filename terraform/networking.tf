resource "aws_vpc" "main_vpc" {
  cidr_block                       = "10.0.0.0/16"
  assign_generated_ipv6_cidr_block = true
  enable_dns_hostnames             = true
  enable_dns_support               = true
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

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "main"
  }
}
resource "aws_egress_only_internet_gateway" "main" {
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
  route_table_id              = aws_route_table.private_route_table.id
  destination_ipv6_cidr_block = "::/0"
  egress_only_gateway_id      = aws_egress_only_internet_gateway.main.id
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

  # ingress {
  #   from_port   = 443
  #   to_port     = 443
  #   protocol    = "tcp"
  #   prefix_list_ids = [data.aws_ec2_managed_prefix_list.cloudfront.id] # Referencing the managed prefix list
  # }


}

resource "aws_security_group" "egress_endpoint_sg" {
  name        = "Allow egress endpoint"
  description = "Allow traffic from egress endpoint"
  vpc_id      = aws_vpc.main_vpc.id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group" "endpoint-sg" {
  name        = "endpoint_access"
  description = "allow inbound traffic"
  vpc_id      = aws_vpc.main_vpc.id
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main_vpc.cidr_block]
    description = "Enable access for the endpoints."
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main_vpc.cidr_block]
  }
  tags = {
    "Name" = "endpoint"
  }
}


resource "aws_vpc_endpoint" "ssm" {
  vpc_id              = aws_vpc.main_vpc.id
  service_name        = "com.amazonaws.us-east-1.ssm"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_subnet.private_subnet.id]
  security_group_ids  = [aws_security_group.endpoint-sg.id]
  private_dns_enabled = true
  tags = {

  }
}
resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id              = aws_vpc.main_vpc.id
  service_name        = "com.amazonaws.us-east-1.ec2messages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_subnet.private_subnet.id]
  security_group_ids  = [aws_security_group.endpoint-sg.id]
  private_dns_enabled = true
  tags = {
    "Name" = "app-1-ec2messages"
  }
}
resource "aws_vpc_endpoint" "messages" {
  vpc_id              = aws_vpc.main_vpc.id
  service_name        = "com.amazonaws.us-east-1.ssmmessages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_subnet.private_subnet.id]
  security_group_ids  = [aws_security_group.endpoint-sg.id]
  private_dns_enabled = true
}

