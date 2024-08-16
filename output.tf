output "sqs_url" {
  value = "${aws_sqs_queue.queue.id}"
}

output "dq_sqs_url" {
  value = "${aws_sqs_queue.deadletter_queue.id}"
}

output "process_lambda_bucket_object" {
  description = "S3 bucket object for the process lambda handler."
  value = aws_s3_bucket_object.process_file_upload
}

output "receive_lambda_bucket_object" {
  description = "S3 bucket object for the receive lambda handler."
  value = aws_s3_bucket_object.receive_file_upload
}

output "flight_data_lambda_bucket_object" {
  description = "S3 bucket object for the flight data lambda handler."
  value = aws_s3_bucket_object.flight_data_file_upload
}

output "function_name" {
  description = "Name of the lambda function."
  value = aws_lambda_function.process_lambda.function_name
}

