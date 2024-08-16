resource "aws_s3_bucket" "lambda-bucket" {
  bucket = "terraform-serverless-lambdacode"

  tags = {
    Name        = "terraform-serverless-lambdacode"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_ownership_controls" "lambda_bucket_ownership_controls" {
  bucket = "${aws_s3_bucket.lambda-bucket.id}"

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "lambda_bucket_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.lambda_bucket_ownership_controls]

  bucket = "${aws_s3_bucket.lambda-bucket.id}"
  acl = "private"
}

# upload zip to s3 and then update lambda function from s3
resource "aws_s3_bucket_object" "process_file_upload" {
  bucket = "${aws_s3_bucket.lambda-bucket.id}"
  key    = "FlightDataProcessor/process_lambda.zip"
  source = "${data.archive_file.process_lambda_handler_archive_file.output_path}" 
}

# upload zip to s3 and then update lambda function from s3
resource "aws_s3_bucket_object" "receive_file_upload" {
  bucket = "${aws_s3_bucket.lambda-bucket.id}"
  key    = "FlightDataProcessor/receive_lambda.zip"
  source = "${data.archive_file.receive_lambda_handler_archive_file.output_path}" 
}

# upload zip to s3 and then update lambda function from s3
resource "aws_s3_bucket_object" "flight_data_file_upload" {
  bucket = "${aws_s3_bucket.lambda-bucket.id}"
  key    = "FlightDataProcessor/flight_data_lambda.zip"
  source = "${data.archive_file.flight_data_lambda_handler_archive_file.output_path}" 
}
