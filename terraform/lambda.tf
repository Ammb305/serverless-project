resource "aws_lambda_function" "api_lambda" {
  filename         = var.artifact_location
  function_name    = "serverless_api"
  role             = aws_iam_role.lambda_s3_aurora.arn
  handler          = "index.handler"
  source_code_hash = filebase64sha256(var.artifact_location)
  runtime          = "nodejs16.x"
  vpc_config {
    subnet_ids         = [for s in aws_subnet.private_subnet : s.id]
    security_group_ids = [aws_security_group.lambda_sg.id]
  }
  environment {
    variables = {
      ENVIRONMENT = "lambda"
      S3_BUCKET   = aws_s3_bucket.private_bucket.id
      REGION      = var.region
      HOST        = aws_rds_cluster.aurora_cluster.endpoint
      DATABASE    = aws_rds_cluster.aurora_cluster.database_name
      SECRET_ID   = aws_rds_cluster.aurora_cluster.master_user_secret[0].secret_arn
    }
  }
  timeout = 30
}