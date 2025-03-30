variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
  default     = "henks-student-data-website"
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  default     = "studentData"
}

variable "dynamodb_hash_key" {
  description = "Hash key for the DynamoDB table"
  default     = "studentid"
}

variable "lambda_exec_role_name" {
  description = "Name of the IAM role for Lambda functions"
  default     = "lambda_exec_role"
}

variable "environment" {
  description = "Environment name"
  default     = "prod"
  
}

