#EC2用のセキュリティグループを作成
resource "aws_security_group" "ec2" {
	name              = "ec2-sg"
	vpc_id            = aws_vpc.main.id
	#ALBからのHTTP通信のみ許可
	ingress {
		from_port = 80
		to_port   = 80
		protcol   = "tcp"
		security_group = [aws_security_group.alb.id]
	}
	#外向き通信は許可
	egress {
		from_port  = 0
		to_port    = 0
		protcol    = "-1"
		cidr_block = ["0.0.0.0/0"]
	}
	tags = {
		Name = "ec2-sg"
	}
}

#Launch Templateを作成
resource "aws_launch_template" "app" {
	name_prefix            = "app-lt-"
	image_id               = "ami-f36dcfcc94112ea1" #Amazon Linux2023を使用
	instance_type          = "t3.micro"
	vpc_security_group_ids = [aws_security_group.ec2.id]
	user_data              = base64encode(<<EOF
	#!/bin/bash
	dnf install -y httpd
	systemctl start httpd
	systemctl enable httpd
	echo "Hello from EC2" > /var/www/html/index.html EOF
)
	tags = {
		Name = "app-launch-template"
	}
}

#ASGを作成
resource "aws_autoscaling_group" "app" {
	desired_capacity = 2
	max_size         = 2
	min_size         = 2
	vpc_zone_identifier = [aws_subnet.private_a.id,aws_subnet.privete_c.id]
	
	target_group_arns = [
	aws_lb_target_group.app.arc
	]
	launch_template {
	id = aws_launch_template.app.id
	version = "$Latest"
	}
	tag {
		key = "Name"
		value = "app-ec2"
		propagate_at_launch = true
	}
}
