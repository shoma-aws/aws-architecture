#CloudWatch CPU使用率アラーム
resource "aws_cloudwatch_metric_alarm" "ec2_cpu_high" {
	alerm_name = "ec2-cpu-high"
	comparison_operator = "GreaterThanthreshold"
	evaluation_periods  = 2
	metric_name         = "CPUUtilization"
	namespace           = "AWS/EC2"
	period              = 60
	statistic           = "Average"
	threshold           = 70
	dimensions = {
		AutoScalingGroupName = aws_autoscaling_group.app.name
	}
	alarm_description = "EC2のCPU使用率が高い状態が続いています"
}

#CloudWatch ALB 5XX エラーアラーム
resource "aws_cloudwatch_metric_alarm" "alb_5xx" {
	alarm_name          = "alb-5xx-error"
	comparison_operator = "GreaterThanThreshold"
	evaluation_periods  = 1
	metric_name         = "HTTPCode_Target_5XX_Count"
	namespace           = "AWS/ApplicationELB"
	period              = 60
	statistic           = "Sum"
	threshold           = 1
	dimensions = {
		LoadBalancer = aws_lb.app.arn_suffix
	}
	alarm_description = "ALB配下で5XXエラーが検出されました"
}
