terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.53.0"
    }
  }
}


data "archive_file" "process_lambda_handler_archive_file" {
  type        = "zip"
  source_dir  = "process_lambda"
  output_path = "process_lambda.zip"
}

data "archive_file" "receive_lambda_handler_archive_file" {
  type        = "zip"
  source_dir  = "receive_lambda"
  output_path = "receive_lambda.zip"
}

data "archive_file" "flight_data_lambda_handler_archive_file" {
  type        = "zip"
  source_dir  = "flight_data_lambda"
  output_path = "flight_data_lambda.zip"
}
