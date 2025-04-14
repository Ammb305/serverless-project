output "vpc_id" {
  value = aws_vpc.dev_vpc.id
}

output "lambda_function_name" {
  value = aws_lambda_function.api_lambda.function_name
}

output "api_gateway_url" {
  value = aws_api_gateway_domain_name.domain.domain_name
}