resource "aws_sns_topic" "alarm_notifications" {
  name = "lambda-alarm-notifications"
  
  tags = {
    Environment = var.environment
    Purpose     = "Lambda Function Alarms"
  }
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.alarm_notifications.arn
  protocol  = "email"
  endpoint  = var.alarm_email
}