Run below terraform command
$ terraform init
$ terraform plan
$ terraform apply

N.B. : assumed that terraform is pre-installed, else need to put terraform.exe in the root directory

Below resources will get created:
1. zip files for lambdas under root directory
2. S3 bucket
3. upload zip to S3 bucket
4. SQS queue
5. Lambda function "receive_lambda", triggered by API gateway
6. Lumbda function "process_lambda" , triggered by SQS event
7. Lambda function "flight_data_lambda" , triggered by APi gateway
8. Necessary IAM roles and permission added as per terraform script
9. API gateway
10. cloudwatch log grooups
