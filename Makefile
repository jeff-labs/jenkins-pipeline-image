COMMIT:=$(shell git describe --always --tags)

help:
	@echo 'Help'

.DEFAULT_GOAL := help

CACHE ?= --no-cache

build-base:
	@echo "Building basic docker image with ${CACHE}"
	docker build ${CACHE} -t "mrjeffapp/jenkins-pipeline:${COMMIT}" --build-arg sonar_scanner_version=4.6.2.2472 -f base/Dockerfile .
	docker tag "mrjeffapp/jenkins-pipeline:${COMMIT}" 'mrjeffapp/jenkins-pipeline:latest'

test-base:
	docker run "mrjeffapp/jenkins-pipeline:${COMMIT}" git --version
	docker run "mrjeffapp/jenkins-pipeline:${COMMIT}" aws --version
	docker run "mrjeffapp/jenkins-pipeline:${COMMIT}" sonar-scanner -v
	docker run "mrjeffapp/jenkins-pipeline:${COMMIT}" helm version

push-base:
	docker push "mrjeffapp/jenkins-pipeline:${COMMIT}"
	docker push 'mrjeffapp/jenkins-pipeline:latest'

build-php: build-base
	@echo 'Building php docker images'
	docker build ${CACHE} -t "mrjeffapp/jenkins-pipeline-php:7.2-${COMMIT}" --build-arg php_version=7.2 -f php/Dockerfile .
	docker tag "mrjeffapp/jenkins-pipeline-php:7.2-${COMMIT}" 'mrjeffapp/jenkins-pipeline-php:7.2'

	docker build ${CACHE} -t "mrjeffapp/jenkins-pipeline-php:7.4-${COMMIT}" --build-arg php_version=7.4 -f php/Dockerfile .
	docker tag "mrjeffapp/jenkins-pipeline-php:7.4-${COMMIT}" 'mrjeffapp/jenkins-pipeline-php:7.4'
	docker tag 'mrjeffapp/jenkins-pipeline-php:7.4' 'mrjeffapp/jenkins-pipeline-php:latest'

test-php:
	docker run "mrjeffapp/jenkins-pipeline-php:7.2-${COMMIT}" php --version
	docker run "mrjeffapp/jenkins-pipeline-php:7.2-${COMMIT}" composer --version
	docker run mrjeffapp/jenkins-pipeline-php:7.4 php --version
	docker run mrjeffapp/jenkins-pipeline-php:7.4 composer --version
	docker run mrjeffapp/jenkins-pipeline-php:latest php --version
	docker run mrjeffapp/jenkins-pipeline-php:latest composer --version

push-php:
	docker push "mrjeffapp/jenkins-pipeline-php:7.2-${COMMIT}"
	docker push "mrjeffapp/jenkins-pipeline-php:7.2"
	docker push "mrjeffapp/jenkins-pipeline-php:7.4-${COMMIT}"
	docker push "mrjeffapp/jenkins-pipeline-php:7.4"
	docker push "mrjeffapp/jenkins-pipeline-php:latest"

build-node: build-base
	docker build ${CACHE} -t "mrjeffapp/jenkins-pipeline-node:12-${COMMIT}" --build-arg base=${COMMIT} --build-arg node_version=12 -f node/Dockerfile .
	docker tag "mrjeffapp/jenkins-pipeline-node:12-${COMMIT}" 'mrjeffapp/jenkins-pipeline-node:12'

	docker build ${CACHE} -t "mrjeffapp/jenkins-pipeline-node:14-${COMMIT}" --build-arg base=${COMMIT} --build-arg node_version=14 -f node/Dockerfile .
	docker tag "mrjeffapp/jenkins-pipeline-node:14-${COMMIT}" 'mrjeffapp/jenkins-pipeline-node:14'

	docker build ${CACHE} -t "mrjeffapp/jenkins-pipeline-node:16-${COMMIT}" --build-arg base=${COMMIT} --build-arg node_version=16 -f node/Dockerfile .
	docker tag "mrjeffapp/jenkins-pipeline-node:16-${COMMIT}" 'mrjeffapp/jenkins-pipeline-node:16'
	docker tag 'mrjeffapp/jenkins-pipeline-node:16' 'mrjeffapp/jenkins-pipeline-node:latest'

test-node:
	docker run "mrjeffapp/jenkins-pipeline-node:12-${COMMIT}" sonar-scanner -v
	docker run "mrjeffapp/jenkins-pipeline-node:12-${COMMIT}" node --version
	docker run "mrjeffapp/jenkins-pipeline-node:12-${COMMIT}" yarn --version

	docker run "mrjeffapp/jenkins-pipeline-node:14-${COMMIT}" node --version
	docker run "mrjeffapp/jenkins-pipeline-node:14-${COMMIT}" yarn --version

	docker run "mrjeffapp/jenkins-pipeline-node:16-${COMMIT}" node --version
	docker run "mrjeffapp/jenkins-pipeline-node:16-${COMMIT}" yarn --version

push-node:
	docker push "mrjeffapp/jenkins-pipeline-node:12-${COMMIT}"
	docker push 'mrjeffapp/jenkins-pipeline-node:12'

	docker push "mrjeffapp/jenkins-pipeline-node:14-${COMMIT}"
	docker push 'mrjeffapp/jenkins-pipeline-node:14'

	docker push "mrjeffapp/jenkins-pipeline-node:16-${COMMIT}"
	docker push 'mrjeffapp/jenkins-pipeline-node:16'
	docker push 'mrjeffapp/jenkins-pipeline-node:latest'

build-java: build-base
	docker build ${CACHE} -t "mrjeffapp/jenkins-pipeline-java:8-${COMMIT}" --build-arg java_version=8 -f java/Dockerfile .
	docker tag "mrjeffapp/jenkins-pipeline-java:8-${COMMIT}" 'mrjeffapp/jenkins-pipeline-java:8'

	docker build ${CACHE} -t "mrjeffapp/jenkins-pipeline-java:11-${COMMIT}" --build-arg java_version=11 -f java/Dockerfile .
	docker tag "mrjeffapp/jenkins-pipeline-java:11-${COMMIT}" 'mrjeffapp/jenkins-pipeline-java:11'

	docker build ${CACHE} -t 'mrjeffapp/jenkins-pipeline-java:17-${COMMIT}' -f java17/Dockerfile .
	docker tag "mrjeffapp/jenkins-pipeline-java:17-${COMMIT}" 'mrjeffapp/jenkins-pipeline-java:17'
	docker tag 'mrjeffapp/jenkins-pipeline-java:17' 'mrjeffapp/jenkins-pipeline-java:latest'

test-java:
	docker run "mrjeffapp/jenkins-pipeline-java:17-${COMMIT}" java --version

push-java:
	docker push "mrjeffapp/jenkins-pipeline-java:8-${COMMIT}"
	docker push 'mrjeffapp/jenkins-pipeline-java:8'
	docker push "mrjeffapp/jenkins-pipeline-java:11-${COMMIT}"
	docker push 'mrjeffapp/jenkins-pipeline-java:11'
	docker push "mrjeffapp/jenkins-pipeline-java:17-${COMMIT}"
	docker push 'mrjeffapp/jenkins-pipeline-java:17'
	docker push 'mrjeffapp/jenkins-pipeline-java:latest'

build: build-base build-php build-node build-java
	@echo 'Build docker images'

test: test-base test-php test-node test-java

push: push-base push-php push-node push-java
	@echo 'Push images'
