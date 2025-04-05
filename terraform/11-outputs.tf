output "website_url" {
  description = "S3 static website hosting endpoint"
  value       = aws_s3_bucket_website_configuration.website_configuration.website_endpoint
  sensitive   = false
}

output "api_endpoint" {
  description = "API Gateway endpoint for the student data API"
  value = "${aws_api_gateway_stage.gateway_stage.invoke_url}/student"
}

output "cloudfront_domain_name" {
  description = "The domain name of the CloudFront distribution"
  value       = aws_cloudfront_distribution.s3_distribution.domain_name
}

output "cloudwatch_dashboard_url" {
  description = "URL of the CloudWatch dashboard"
  value       = "https://${var.aws_region}.console.aws.amazon.com/cloudwatch/home?region=${var.aws_region}#dashboards:name=${aws_cloudwatch_dashboard.lambda_dashboard.dashboard_name}"
}

output "sns_topic_arn" {
  description = "The ARN of the SNS topic for alarms"
  value       = aws_sns_topic.alarm_notifications.arn
}

