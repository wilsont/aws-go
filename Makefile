#include .env if exists
-include .env

.DEFAULT_GOAL:=help


.PHONY: help
help: ## this help
	@grep -h -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build:
	GOOS=linux go build main.go && rm function.zip && zip function.zip main

update: 
	aws lambda update-function-code --function-name testHandler --zip-file fileb://function.zip
