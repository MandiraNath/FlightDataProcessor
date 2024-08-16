resource "aws_cloudwatch_log_group" "api" {
  name = "/aws/api-gateway/api"
  retention_in_days = 30

  lifecycle {
    prevent_destroy = false
  }
}


resource "aws_cloudwatch_log_group" "receive_lambda" {
  name = "/aws/lambda/ReceiveLambda"
  retention_in_days = 30

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_cloudwatch_log_group" "process_lambda" {
  name = "/aws/lambda/ProcessLambda"
  retention_in_days = 30

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_cloudwatch_log_group" "fligthDataLambda_lambda" {
  name = "/aws/lambda/FligthDataLambda"
  retention_in_days = 30

  lifecycle {
    prevent_destroy = false
  }
}