# CloudWatch Alarms for Lambda Functions
resource "aws_cloudwatch_metric_alarm" "insert_student_data_errors" {
  alarm_name          = "InsertStudentDataErrors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  period              = 300
  statistic           = "Sum"
  threshold           = 1
  alarm_actions       = [aws_sns_topic.alarm_notifications.arn]
  dimensions = {
    FunctionName = aws_lambda_function.insert_student_data.function_name
  }
}

resource "aws_cloudwatch_metric_alarm" "get_students_errors" {
  alarm_name          = "GetStudentsErrors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  period              = 300
  statistic           = "Sum"
  threshold           = 1
  alarm_actions       = [aws_sns_topic.alarm_notifications.arn]
  dimensions = {
    FunctionName = aws_lambda_function.get_students.function_name
  }
}