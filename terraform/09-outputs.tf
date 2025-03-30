output "website_url" {
  description = "S3 static website hosting endpoint"
  value       = aws_s3_bucket_website_configuration.website_configuration.website_endpoint
  sensitive   = false
}

output "api_endpoint" {
  value = "${aws_api_gateway_stage.gateway_stage.invoke_url}/student"
}

output "cloudfront_domain_name" {
  description = "The domain name of the CloudFront distribution"
  value       = aws_cloudfront_distribution.s3_distribution.domain_name
}