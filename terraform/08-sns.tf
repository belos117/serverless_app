resource "aws_sns_topic" "alarm_notifications" {
  name = "AlarmNotifications"
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.alarm_notifications.arn
  protocol  = "email"
  endpoint  = "belos117@gmail.com"
}