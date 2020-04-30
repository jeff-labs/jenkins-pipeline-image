
help:
	@echo 'Help'

.DEFAULT_GOAL := help

build:
	@echo 'Build docker images'
	docker build --no-cache -t 'mrjeffapp/jenkins-pipeline-base' -f base/Dockerfile .

	docker build --no-cache -t 'mrjeffapp/jenkins-pipeline-node:8' --build-arg node_version=8 -f node/Dockerfile .
	docker build --no-cache -t 'mrjeffapp/jenkins-pipeline-node:10' --build-arg node_version=10 -f node/Dockerfile .
	docker build --no-cache -t 'mrjeffapp/jenkins-pipeline-node:12' --build-arg node_version=12 -f node/Dockerfile .
	docker tag 'mrjeffapp/jenkins-pipeline-node:12' 'mrjeffapp/jenkins-pipeline-node:latest'

	docker build --no-cache -t 'mrjeffapp/jenkins-pipeline-java:8' --build-arg java_version=8 -f java/Dockerfile .
	docker build --no-cache -t 'mrjeffapp/jenkins-pipeline-java:11' --build-arg java_version=11 -f java/Dockerfile .
	docker build --no-cache -t 'mrjeffapp/jenkins-pipeline-java:14' --build-arg java_version=14 -f java/Dockerfile .
	docker tag 'mrjeffapp/jenkins-pipeline-java:14' 'mrjeffapp/jenkins-pipeline-java:latest'

push:
	@echo 'Push images'
	docker push 'mrjeffapp/jenkins-pipeline-base'

	docker push 'mrjeffapp/jenkins-pipeline-node:8'
	docker push 'mrjeffapp/jenkins-pipeline-node:10'
	docker push 'mrjeffapp/jenkins-pipeline-node:12'
	docker push 'mrjeffapp/jenkins-pipeline-node:latest'

	docker push 'mrjeffapp/jenkins-pipeline-java:8'
	docker push 'mrjeffapp/jenkins-pipeline-java:11'
	docker push 'mrjeffapp/jenkins-pipeline-java:14'
	docker push 'mrjeffapp/jenkins-pipeline-java:latest'

clean:
	@echo 'Clean images'
	docker rmi 'mrjeffapp/jenkins-pipeline-java:latest'
	docker rmi 'mrjeffapp/jenkins-pipeline-java:14'
	docker rmi 'mrjeffapp/jenkins-pipeline-java:11'
	docker rmi 'mrjeffapp/jenkins-pipeline-java:8'

	docker rmi 'mrjeffapp/jenkins-pipeline-node:latest'
	docker rmi 'mrjeffapp/jenkins-pipeline-node:12'
	docker rmi 'mrjeffapp/jenkins-pipeline-node:10'
	docker rmi 'mrjeffapp/jenkins-pipeline-node:8'

	docker rmi 'mrjeffapp/jenkins-pipeline-base'
