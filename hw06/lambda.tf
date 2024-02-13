resource "aws_lambda_permission" "api_gw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.proxy_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.api_gateway_rest_api.execution_arn}/*/*"
}

resource "aws_lambda_function" "proxy_lambda" {
  filename      = "proxy_lambda.zip"
  function_name = "proxy_lambda_function"
  handler       = "proxy_lambda.lambda_handler"
  runtime       = "python3.10"
  role          = aws_iam_role.iam_for_lambda.arn
}

resource "aws_lambda_function" "weather_lambda" {
  filename      = "weather_lambda.zip"
  function_name = "weather_lambda_function"
  handler       = "weather_lambda.lambda_handler"
  runtime       = "python3.10"
  role          = aws_iam_role.iam_for_lambda.arn
}
