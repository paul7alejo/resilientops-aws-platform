resource "aws_security_group" "alb" {
  name        = "resilientops-alb-sg"
  description = "Allows HTTPS traffic to the public load balancer."
  vpc_id      = aws_vpc.resilientops.id

  ingress {
    description = "HTTPS from internet users"
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow outbound traffic"
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "resilientops-alb-sg"
    Tier = "public"
  }
}

resource "aws_security_group" "app" {
  name        = "resilientops-app-sg"
  description = "Allows application traffic only from the load balancer."
  vpc_id      = aws_vpc.resilientops.id

  ingress {
    description     = "Application traffic from ALB"
    protocol        = "tcp"
    from_port       = 8080
    to_port         = 8080
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    description = "Allow outbound traffic"
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "resilientops-app-sg"
    Tier = "private"
  }
}
