resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = merge(var.tags, {
  Name = "${var.cluster_name}-vpc" })
}

resource "aws_subnet" "public" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = "${var.cluster_name}-public-${count.index + 1}"
  })
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.tags, {
    Name = "${var.cluster_name}-igw"
  })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(var.tags, {
    Name = "${var.cluster_name}-public-rtb"
  })
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

// Security Group for jenkins (master and agents)
resource "aws_security_group" "jenkins" {
  name        = "${var.cluster_name}-jenkins-sg"
  vpc_id      = aws_vpc.main.id
  description = "Security Group for Jenkins"


  tags = merge(var.tags, {
    Name = "${var.cluster_name}-jenkins-sg"
  })
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.jenkins.id
  description       = "Allow SSH from admin IP"
  cidr_ipv4         = var.admin_ip
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
  tags              = var.tags
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_8080" {
  security_group_id = aws_security_group.jenkins.id
  description       = "Allow HTTP port 8080 from admin IP"
  cidr_ipv4         = var.admin_ip
  from_port         = 8080
  ip_protocol       = "tcp"
  to_port           = 8080
  tags              = var.tags

}

resource "aws_vpc_security_group_ingress_rule" "allow_http_8080_within_subnet" {
  security_group_id = aws_security_group.jenkins.id
  description       = "Allow HTTP port 8080 from admin IP"
  cidr_ipv4         = aws_subnet.public[0].cidr_block
  from_port         = 8080
  ip_protocol       = "tcp"
  to_port           = 8080
  tags              = var.tags

}

resource "aws_vpc_security_group_ingress_rule" "allow_jnlp_50000" {
  security_group_id = aws_security_group.jenkins.id
  description       = "Allow JNLP port 50000 from VPC CIDR"
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 50000
  ip_protocol       = "tcp"
  to_port           = 50000
  tags              = var.tags
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.jenkins.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
  tags              = var.tags
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.jenkins.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
  tags              = var.tags
}