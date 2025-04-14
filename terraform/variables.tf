variable "api_stage" {
  description = "API Gateway stage name"
  type        = string
  default     = "dev"
}

variable "artifact_location" {
  description = "Path to the Lambda function artifact"
  type        = string
  default     = "../serverless-api/lambda_function.zip"
}

variable "aws_profile" {
  description = "AWS profile name for tagging"
  type        = string
  default     = "default-profile"
}

variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "domain" {
  description = "Custom domain for API Gateway"
  type        = string
  default     = "learningdevops.site"
}

variable "private_subnets" {
  description = "Number of private subnets to create"
  type        = number
  default     = 2
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}