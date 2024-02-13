zip-proxy-lambda:
	@echo "+ $@"
	@cd package/ && zip -r ../proxy_lambda.zip .
	@zip proxy_lambda.zip proxy_lambda.py
.PHONY: zip-proxy-lambda

zip-weather-lambda:
	@echo "+ $@"
	@cd package/ && zip -r ../weather_lambda.zip .
	@zip weather_lambda.zip weather_lambda.py
.PHONY: zip-proxy-lambda

zip-lambdas: zip-proxy-lambda zip-weather-lambda
.PHONY: zip-lambdas