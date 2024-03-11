resource "null_resource" "create_lambda_zip" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "zip -r lambda.zip src/*"
  }
}


provider "aws" {
  region = "us-east-1"
}

# Definindo a função Lambda
resource "aws_lambda_function" "auth_lambda" {
  filename         = "lambda.zip"  
  function_name    = "auth_lambda" 
  role             = aws_iam_role.lambda_exec.arn
  handler          = "index.handler" 
  runtime          = "nodejs20.x"
  timeout          = 10 
}

# Definindo a política de execução para a função Lambda
resource "aws_iam_role" "lambda_exec" {
  name = "lambda-exec-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Anexando a política de execução à função Lambda
resource "aws_iam_policy_attachment" "lambda_execution" {
  name       = "lambda-execution-policy"
  roles      = [aws_iam_role.lambda_exec.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}