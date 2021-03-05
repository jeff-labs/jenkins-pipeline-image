COMMIT:=$(shell git describe --always --tags)

help:
	@echo 'Help'

.DEFAULT_GOAL := help

build-base:
	@echo "Building basic docker image"
	docker build --no-cache -t "mrjeffapp/jenkins-pipeline:${COMMIT}" -f base/Dockerfile .
	docker tag "mrjeffapp/jenkins-pipeline:${COMMIT}" 'mrjeffapp/jenkins-pipeline:latest'
	docker tag "mrjeffapp/jenkins-pipeline:${COMMIT}" 'mrjeffapp/jenkins-pipeline-base:latest'

build-php: build-base
	@echo 'Building php docker images'
	docker build --no-cache -t 'mrjeffapp/jenkins-pipeline-php:7.2' --build-arg php_version=7.2 -f php/Dockerfile .
	docker tag 'mrjeffapp/jenkins-pipeline-php:7.2' 'mrjeffapp/jenkins-pipeline-php:latest'

test-base:
	docker run "mrjeffapp/jenkins-pipeline:${COMMIT}" git --version
	docker run "mrjeffapp/jenkins-pipeline:${COMMIT}" aws --version

test-php:
	docker run mrjeffapp/jenkins-pipeline-php:latest php --version
	docker run mrjeffapp/jenkins-pipeline-php:latest composer --version

push-php:
	docker push mrjeffapp/jenkins-pipeline-php:7.2
	docker push mrjeffapp/jenkins-pipeline-php:latest

clean-php:
	docker rmi mrjeffapp/jenkins-pipeline-php:latest
	docker rmi mrjeffapp/jenkins-pipeline-php:7.2

build: build-base build-php
	@echo 'Build docker images'

	docker build --no-cache -t 'mrjeffapp/jenkins-pipeline-node:8' --build-arg node_version=8 -f node/Dockerfile .
	docker build --no-cache -t 'mrjeffapp/jenkins-pipeline-node:10' --build-arg node_version=10 -f node/Dockerfile .
	docker build --no-cache -t 'mrjeffapp/jenkins-pipeline-node:12' --build-arg node_version=12 -f node/Dockerfile .
	docker tag 'mrjeffapp/jenkins-pipeline-node:12' 'mrjeffapp/jenkins-pipeline-node:latest'

	docker build --no-cache -t 'mrjeffapp/jenkins-pipeline-java:8' --build-arg java_version=8 -f java/Dockerfile .
	docker build --no-cache -t 'mrjeffapp/jenkins-pipeline-java:10' -f java10/Dockerfile .
	docker build --no-cache -t 'mrjeffapp/jenkins-pipeline-java:11' --build-arg java_version=11 -f java/Dockerfile .
	docker build --no-cache -t 'mrjeffapp/jenkins-pipeline-java:14' --build-arg java_version=14 -f java/Dockerfile .
	docker tag 'mrjeffapp/jenkins-pipeline-java:14' 'mrjeffapp/jenkins-pipeline-java:latest'

test: test-base test-php

push: push-php
	@echo 'Push images'
	docker push 'mrjeffapp/jenkins-pipeline-base'

	docker push 'mrjeffapp/jenkins-pipeline-node:8'
	docker push 'mrjeffapp/jenkins-pipeline-node:10'
	docker push 'mrjeffapp/jenkins-pipeline-node:12'
	docker push 'mrjeffapp/jenkins-pipeline-node:latest'

	docker push 'mrjeffapp/jenkins-pipeline-java:8'
	docker push 'mrjeffapp/jenkins-pipeline-java:10'
	docker push 'mrjeffapp/jenkins-pipeline-java:11'
	docker push 'mrjeffapp/jenkins-pipeline-java:14'
	docker push 'mrjeffapp/jenkins-pipeline-java:latest'

clean: clean-php
	@echo 'Clean images'
	docker rmi 'mrjeffapp/jenkins-pipeline-java:latest'
	docker rmi 'mrjeffapp/jenkins-pipeline-java:14'
	docker rmi 'mrjeffapp/jenkins-pipeline-java:11'
	docker rmi 'mrjeffapp/jenkins-pipeline-java:10'
	docker rmi 'mrjeffapp/jenkins-pipeline-java:8'

	docker rmi 'mrjeffapp/jenkins-pipeline-node:latest'
	docker rmi 'mrjeffapp/jenkins-pipeline-node:12'
	docker rmi 'mrjeffapp/jenkins-pipeline-node:10'
	docker rmi 'mrjeffapp/jenkins-pipeline-node:8'

	docker rmi 'mrjeffapp/jenkins-pipeline-base'
