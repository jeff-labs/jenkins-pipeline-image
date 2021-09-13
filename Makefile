COMMIT:=$(shell git describe --always --tags)

help:
	@echo 'Help'

.DEFAULT_GOAL := help

build-base:
	@echo "Building basic docker image"
	docker build --no-cache -t "mrjeffapp/jenkins-pipeline:${COMMIT}" --build-arg sonar_scanner_version=4.6.0.2311 -f base/Dockerfile .
	docker tag "mrjeffapp/jenkins-pipeline:${COMMIT}" 'mrjeffapp/jenkins-pipeline:latest'

test-base:
	docker run "mrjeffapp/jenkins-pipeline:${COMMIT}" git --version
	docker run "mrjeffapp/jenkins-pipeline:${COMMIT}" aws --version
	docker run "mrjeffapp/jenkins-pipeline:${COMMIT}" sonar-scanner -v

push-base:
	docker push "mrjeffapp/jenkins-pipeline:${COMMIT}"
	docker push 'mrjeffapp/jenkins-pipeline:latest'

build-php: build-base
	@echo 'Building php docker images'
	docker build --no-cache -t "mrjeffapp/jenkins-pipeline-php:7.2-${COMMIT}" --build-arg php_version=7.2 -f php/Dockerfile .
	docker tag "mrjeffapp/jenkins-pipeline-php:7.2-${COMMIT}" 'mrjeffapp/jenkins-pipeline-php:7.2'

	docker build --no-cache -t "mrjeffapp/jenkins-pipeline-php:7.4-${COMMIT}" --build-arg php_version=7.4 -f php/Dockerfile .
	docker tag "mrjeffapp/jenkins-pipeline-php:7.4-${COMMIT}" 'mrjeffapp/jenkins-pipeline-php:7.4'
	docker tag 'mrjeffapp/jenkins-pipeline-php:7.4' 'mrjeffapp/jenkins-pipeline-php:latest'

test-php:
	docker run mrjeffapp/jenkins-pipeline-php:7.2 php --version
	docker run mrjeffapp/jenkins-pipeline-php:7.2 composer --version
	docker run mrjeffapp/jenkins-pipeline-php:7.4 php --version
	docker run mrjeffapp/jenkins-pipeline-php:7.4 composer --version
	docker run mrjeffapp/jenkins-pipeline-php:latest php --version
	docker run mrjeffapp/jenkins-pipeline-php:latest composer --version

push-php:
	docker push mrjeffapp/jenkins-pipeline-php:7.2
	docker push mrjeffapp/jenkins-pipeline-php:7.4
	docker push mrjeffapp/jenkins-pipeline-php:latest

build-node: build-base
	docker build --no-cache -t "mrjeffapp/jenkins-pipeline-node:8-${COMMIT}" --build-arg base=${COMMIT} --build-arg node_version=8 -f node/Dockerfile .
	docker tag "mrjeffapp/jenkins-pipeline-node:8-${COMMIT}" 'mrjeffapp/jenkins-pipeline-node:8'

	docker build --no-cache -t "mrjeffapp/jenkins-pipeline-node:10-${COMMIT}" --build-arg base=${COMMIT} --build-arg node_version=10 -f node/Dockerfile .
	docker tag "mrjeffapp/jenkins-pipeline-node:10-${COMMIT}" 'mrjeffapp/jenkins-pipeline-node:10'

	docker build --no-cache -t "mrjeffapp/jenkins-pipeline-node:12-${COMMIT}" --build-arg base=${COMMIT} --build-arg node_version=12 -f node/Dockerfile .
	docker tag "mrjeffapp/jenkins-pipeline-node:12-${COMMIT}" 'mrjeffapp/jenkins-pipeline-node:12'

	docker build --no-cache -t "mrjeffapp/jenkins-pipeline-node:14-${COMMIT}" --build-arg base=${COMMIT} --build-arg node_version=14 -f node/Dockerfile .
	docker tag "mrjeffapp/jenkins-pipeline-node:14-${COMMIT}" 'mrjeffapp/jenkins-pipeline-node:14'
	docker tag 'mrjeffapp/jenkins-pipeline-node:14' 'mrjeffapp/jenkins-pipeline-node:latest'

test-node:
	docker run "mrjeffapp/jenkins-pipeline-node:8-${COMMIT}" node --version
	docker run "mrjeffapp/jenkins-pipeline-node:8-${COMMIT}" yarn --version

	docker run "mrjeffapp/jenkins-pipeline-node:10-${COMMIT}" node --version
	docker run "mrjeffapp/jenkins-pipeline-node:10-${COMMIT}" yarn --version
	docker run "mrjeffapp/jenkins-pipeline-node:10-${COMMIT}" sonar-scanner -v

	docker run "mrjeffapp/jenkins-pipeline-node:12-${COMMIT}" node --version
	docker run "mrjeffapp/jenkins-pipeline-node:12-${COMMIT}" yarn --version

	docker run "mrjeffapp/jenkins-pipeline-node:14-${COMMIT}" node --version
	docker run "mrjeffapp/jenkins-pipeline-node:14-${COMMIT}" yarn --version

push-node:
	docker push "mrjeffapp/jenkins-pipeline-node:8-${COMMIT}"
	docker push 'mrjeffapp/jenkins-pipeline-node:8'

	docker push "mrjeffapp/jenkins-pipeline-node:10-${COMMIT}"
	docker push 'mrjeffapp/jenkins-pipeline-node:10'

	docker push "mrjeffapp/jenkins-pipeline-node:12-${COMMIT}"
	docker push 'mrjeffapp/jenkins-pipeline-node:12'

	docker push "mrjeffapp/jenkins-pipeline-node:14-${COMMIT}"
	docker push 'mrjeffapp/jenkins-pipeline-node:14'
	docker push 'mrjeffapp/jenkins-pipeline-node:latest'

build: build-base build-php build-node
	@echo 'Build docker images'

	docker build --no-cache -t 'mrjeffapp/jenkins-pipeline-java:8' --build-arg java_version=8 -f java/Dockerfile .
	docker build --no-cache -t 'mrjeffapp/jenkins-pipeline-java:11' --build-arg java_version=11 -f java/Dockerfile .
	docker build --no-cache -t 'mrjeffapp/jenkins-pipeline-java:14' --build-arg java_version=14 -f java/Dockerfile .
	docker tag 'mrjeffapp/jenkins-pipeline-java:14' 'mrjeffapp/jenkins-pipeline-java:latest'

test: test-base test-php test-node

push: push-base push-php push-node
	@echo 'Push images'
	docker push 'mrjeffapp/jenkins-pipeline-java:8'
	docker push 'mrjeffapp/jenkins-pipeline-java:11'
	docker push 'mrjeffapp/jenkins-pipeline-java:14'
	docker push 'mrjeffapp/jenkins-pipeline-java:latest'
