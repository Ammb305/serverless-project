resource "aws_security_group" "endpoint_sg" {
  name        = "${var.aws_profile}-endpoint-sg"
  description = "Interface Endpoint security group to allow inbound/outbound from the VPC"
  vpc_id      = aws_vpc.dev_vpc.id

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.lambda_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.aws_profile}-endpoint-sg"
  }

  depends_on = [aws_security_group.lambda_sg]
}

resource "aws_security_group" "db-sg" {
  name        = "${var.aws_profile}-database-sg"
  description = "Database security group to allow inbound/outbound from the VPC"
  vpc_id      = aws_vpc.dev_vpc.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.lambda_sg.id]
  }

  tags = {
    Name = "${var.aws_profile}-database-sg"
  }

  depends_on = [aws_security_group.lambda_sg]
}

resource "aws_security_group" "lambda_sg" {
  name        = "${var.aws_profile}-lambda-sg"
  description = "Lambda security group to allow inbound/outbound from the VPC"
  vpc_id      = aws_vpc.dev_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.aws_profile}-lambda-sg"
  }
}