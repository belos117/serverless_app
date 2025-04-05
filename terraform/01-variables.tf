/*
 * This file contains the variable definitions for the Terraform configuration.
 * It includes variables for AWS region, S3 bucket name, DynamoDB table name,
 * IAM role names, and environment settings.
 */

# Variables for Provider Configuration
variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

# Variables for S3
variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
  default     = "henks-student-data-website"
}

# Variables for DynamoDB
variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  default     = "studentData"
}

variable "dynamodb_hash_key" {
  description = "Hash key for the DynamoDB table"
  default     = "studentid"
}

# Variables for IAM roles
variable "lambda_exec_role_name" {
  description = "Name of the IAM role for Lambda functions"
  default     = "lambda_exec_role"
}
# Variables for Lambda functions
variable "insert_student_data" {
  description = "Name of the Lambda function for inserting student data"
  default     = "insertStudentData"
}
variable "get_students" {
  description = "Name of the Lambda function for getting student data"
  default     = "getStudents"
}

variable "insert_student_data_hash" {
  description = "Source code hash for the insert student data Lambda function"
  default     = "./src/insertStudentData.zip"
}
variable "get_students_hash" {
  description = "Source code hash for the get students Lambda function"
  default     = "./src/getStudents.zip"
}

variable "runtime" {
  description = "Runtime for the Lambda functions"
  default     = "python3.12"
}

# Variables for API Gateway
variable "api_gateway_name" {
  description = "Name of the API Gateway"
  default     = "StudentDataAPI"
}

variable "api_gateway_resource_path" {
  description = "Resource path for the API Gateway"
  default     = "student"
}

variable "api_gateway_post_method" {
  description = "HTTP method for the API Gateway"
  default     = "POST"
}

variable "api_gateway_integration_type" {
  description = "Integration type for the API Gateway"
  default     = "AWS_PROXY"
}

variable "api_gateway_get_method" {
  description = "HTTP method for the API Gateway"
  default     = "GET"
}

variable "api_gateway_options_method" {
  description = "HTTP method for the API Gateway"
  default     = "OPTIONS"
}

variable "api_gateway_options_integration_type" {
  description = "Integration type for the API Gateway OPTIONS method"
  default     = "MOCK"
}

variable "api_gateway_options_integration_response_status_code" {
  description = "Response status code for the API Gateway OPTIONS method"
  default     = 200
}

variable "authorization" {
  description = "value for the authorization header"
  default = "NONE"
}

variable "environment" {
  description = "Environment name"
  default     = "prod"
}

# Variables for CloudWatch
variable "cloudwatch_dashboard_name" {
  description = "Name of the CloudWatch dashboard"
  default     = "StudentAPI-Dashboard"
}

# Variables for SNS

variable "sns_topic_name" {
  description = "Name of the SNS topic"
  default     = "lambda-alarm-notifications"
}

variable "alarm_email" {
  description = "Email address for alarm notifications"
  type        = string
  default     = "belos117@gmail.com"
}

# Variables for CloudTrail

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "student-management"
}

