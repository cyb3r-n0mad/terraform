
# VPC module

# Building block for a VPC. Using a variable for cidr so each network can place own
resource "aws_vpc" "this" {
    cidr_block = var.cidr     # sets a variable for IP range
    enable_dns_support = true    #enables DNS support
    enable_dns_hostnames = true   # enables DNS hostnames
  
  # tag here lets user generate name in environment
    tags = {
      Name = var.name
    }
}

# Building block for a public subnet
resource "aws_subnet" "public" {
  count = length(var.public_subnets)
  vpc_id = aws_vpc.this.id    # "THIS VPC ID" means it will inherit from the above VPC creation
  cidr_block = var.public_subnets[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}-public-${count.index}"
  }
}