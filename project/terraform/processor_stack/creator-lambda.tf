# data.terraform_remote_state.artifact_module.outputs.artifactbucket_name

resource "aws_s3_bucket_object" "creator_lambda_code" {
  bucket = "arn:aws:s3:::${module.artifact_module.artifactbucket_arn}"
  key    = "CreatorFunction.zip"
  source = "CreatorFunction.zip"
}


resource "aws_lambda_function" "creator_lambda" {
  filename         = "CreatorFunction.zip"
  function_name    = "CreatorFunction"
  role             = module.artifact_module.aws_iam_role_arn
  handler          = "CreatorFunction::CreatorFunction.Function::FunctionHandler"
  source_code_hash = filebase64sha256("${aws_s3_bucket_object.creator_lambda_code.source}")
  runtime          = "dotnetcore3.1"
  environment {
    variables = {
      QueueName = aws_sqs_queue.jogday_queue.name
      DLQName = aws_sqs_queue.deadletter_queue.name
    }
  }
}

resource "aws_lambda_permission" "creator_lambda" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.creator_lambda.function_name
  principal     = module.artifact_module.aws_iam_user_arn
}


  # Policy statement to allow access to other AWS resources
  # For example: access to S3 or DynamoDB
  # policy = jsonencode({
  #   Version = "2012-10-17"
  #   Statement = [
  #     {
  #       Effect = "Allow"
  #       Action = [
  #         "s3:GetObject",
  #         "s3:PutObject",
  #         "dynamodb:Scan",
  #         "dynamodb:PutItem",
  #         "dynamodb:GetItem"
  #       ]
  #       Resource = "*"
  #     }
  #   ]
  # })

# resource "aws_cloudwatch_event_rule" "example" {
#   name        = "example-lambda-trigger"
#   description = "Example CloudWatch event trigger"
#   schedule_expression = "cron(0 12 * * ? *)"
# }

# resource "aws_cloudwatch_event_target" "example" {
#   rule      = aws_cloudwatch_event_rule.example.name
#   arn       = aws_lambda_function.example.arn
#   target_id = "example-lambda-target"
# }
