resource "aws_lambda_function" "process_lambda" {
  function_name = "ProcessLambda"

  # The bucket name as created earlier with "aws s3api create-bucket"
  
  memory_size = 1024
  # "process_lambda" is the filename within the zip file (process_lambda.js) and "handler"
  # is the name of the property under which the handler function was
  # exported in that file.
  role             = "${aws_iam_role.lambda_exec.arn}"
  handler          = "process_lambda.handler"
  filename = "${data.archive_file.process_lambda_handler_archive_file.output_path}"
  source_code_hash = "${data.archive_file.process_lambda_handler_archive_file.output_base64sha256}"
  runtime          = "nodejs16.x"
  environment {
    variables = {
      QUEUE_URL = aws_sqs_queue.queue.name
      DQUEUE_URL = aws_sqs_queue.deadletter_queue.name
    }
  }
}

resource "aws_lambda_function" "receive_lambda" {
  function_name = "ReceiveLambda"

  # The bucket name as created earlier with "aws s3api create-bucket"
  
  

  memory_size = 512
  
  # "receive_lambda" is the filename within the zip file (receive_lambda.js) and "handler"
  # is the name of the property under which the handler function was
  # exported in that file.
  role             = "${aws_iam_role.lambda_exec.arn}"
  handler          = "receive_lambda.handler"
  filename = "${data.archive_file.receive_lambda_handler_archive_file.output_path}"
  source_code_hash = "${data.archive_file.receive_lambda_handler_archive_file.output_base64sha256}"
  runtime          = "nodejs16.x"
  environment {
    variables = {
      QUEUE_URL = aws_sqs_queue.queue.name
      DQUEUE_URL = aws_sqs_queue.deadletter_queue.name
    }
  }
}

resource "aws_lambda_function" "flight_data_lambda" {
  function_name = "FligthDataLambda"

  # The bucket name as created earlier with "aws s3api create-bucket"
  
  
  memory_size = 512

  # "flight_data_lambda" is the filename within the zip file (flight_data_lambda.js) and "handler"
  # is the name of the property under which the handler function was
  # exported in that file.
  role             = "${aws_iam_role.lambda_exec.arn}"
  handler          = "flight_data_lambda.handler"
  filename = "${data.archive_file.flight_data_lambda_handler_archive_file.output_path}"
  source_code_hash = "${data.archive_file.flight_data_lambda_handler_archive_file.output_base64sha256}"
  runtime          = "nodejs16.x"
}

data "aws_lambda_function" "FligthDataLambda" {
  function_name = "FligthDataLambda"
}

data "aws_lambda_function" "ReceiveLambda" {
  function_name = "ReceiveLambda"
}

