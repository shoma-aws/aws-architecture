#ALB用のセキュリティグループを作成
resource "aws_security_group" "alb"
	name = "alb-sg"
	vpc_id = aws_vpc.main.id
	ingress {
		from_port = 80
		to_port = 80
		protocol = "tcp
		cidr_blocks = ["0.0.0.0/0"]
	}
	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	} 		
	tags = {
		Name = "alb-sg"
	}
}

#ALBを作成
resource "aws_alb" "app" {
	name = "app-alb"
	load_balancer_type = "application"
	internal = false
	security_groups = [aws_security_group.alb.id]
	subnets = [
		aws_subnet.public_a.id,aws_subnet.public_c.id
		]
	tags = {
		Name = "app-alb"
	}
}

#TargetGroupを作成
resource "aws_lb_target_group" "app" {
	name = "app-tg"
	port = 80
	protocol = "HTTP"
	vpc_id = aws_vpc.main.id
	health_check {
		path = "/"          #とりあえず"/"で指定。ヘルスチェック用のサーバーがあればそれに変更
		}
	tags = {
		Name = "app-tg"
	}
}
#ALB listenerを作成
resource "aws_lb_listener" "http" {
	load_balancer_arn = aws_lb.app.arn
	port              = 80
	protocol          = "HTTP"
	default_action {
		type      = "forward"
		target_group_arn = aws_lb_target_group.app.arn
	}
}
