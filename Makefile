
help:
	@echo 'Help'

.DEFAULT_GOAL := help

build:
	@echo 'Build docker images'
	docker build --no-cache -t 'mrjeffapp/jenkins-pipeline-base' -f base/Dockerfile .
	docker build --no-cache -t 'mrjeffapp/jenkins-pipeline-node8' --build-arg node_version=8 -f node/Dockerfile .
	docker build --no-cache -t 'mrjeffapp/jenkins-pipeline-node12' --build-arg node_version=12 -f node/Dockerfile .
	docker build --no-cache -t 'mrjeffapp/jenkins-pipeline-java11' --build-arg java_version=11 -f java/Dockerfile .

push:
	@echo 'Push images'
	docker push 'mrjeffapp/jenkins-pipeline-base'
	docker push 'mrjeffapp/jenkins-pipeline-node8'
	docker push 'mrjeffapp/jenkins-pipeline-node12'
	docker push 'mrjeffapp/jenkins-pipeline-java11'

clean:
	@echo 'Clean images'
	docker rmi 'mrjeffapp/jenkins-pipeline-java11'
	docker rmi 'mrjeffapp/jenkins-pipeline-node12'
	docker rmi 'mrjeffapp/jenkins-pipeline-node8'
	docker rmi 'mrjeffapp/jenkins-pipeline-base'
