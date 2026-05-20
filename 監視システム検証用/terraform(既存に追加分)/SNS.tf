#SNSトピック
resource "aws_sns_topic" "alert" {
  name = "ai-monitor-alert"
}

#メール通知
resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alert.arn
  protocol  = "email"
  endpoint  = "***@example.com"
}
