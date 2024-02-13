data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

data "aws_iam_policy_document" "proxy_lambda_lambda_policy_document" {
  statement {
    actions = [
      "dynamodb:Scan",
      "dynamodb:PutItem",
      "dynamodb:BatchWriteItem",
      "dynamodb:UpdateItem"
    ]
    resources = [
      aws_dynamodb_table.stats_table.arn
    ]
  }

  statement {
    actions = [
      "lambda:InvokeFunction"
    ]
    resources = [
      aws_lambda_function.weather_lambda.arn
    ]
  }
}


resource "aws_iam_policy" "proxy_lambda_policy" {
  name        = "proxy_lambda_policy"
  policy      = data.aws_iam_policy_document.proxy_lambda_lambda_policy_document.json
}

resource "aws_iam_role_policy_attachment" "lambda_attachments" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.proxy_lambda_policy.arn
}

