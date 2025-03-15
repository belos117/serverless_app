output "website_url" {
  description = "S3 static website hosting endpoint"
  value       = aws_s3_bucket_website_configuration.website_configuration.website_endpoint
  sensitive   = false
}

output "api_endpoint" {
  value = "${aws_api_gateway_stage.gateway_stage.invoke_url}/student"
}