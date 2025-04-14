resource "aws_subnet" "private_subnet" {
  count             = var.private_subnets
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = cidrsubnet(var.cidr_block, 4, count.index + 1)
  availability_zone = element(data.aws_availability_zones.all.names, count.index % length(data.aws_availability_zones.all.names))
  tags = {
    Name = "${aws_vpc.dev_vpc.id}-Private subnet ${count.index + 1}"
  }
}   