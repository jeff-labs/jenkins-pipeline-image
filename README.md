# Jenkins pipeline images

Docker images to use as an agent in [Jenkins pipelines](https://www.jenkins.io/doc/book/pipeline/docker/).

Based in the [CircleCI images project](https://github.com/circleci/circleci-images) and the [Bitbucket pipelines default image](https://hub.docker.com/r/atlassian/default-image/)

## Status
![Build and push images](https://github.com/jeff-labs/jenkins-pipeline-image/workflows/Build%20and%20push%20images/badge.svg?branch=master)

## Images

### [jenkins-pipeline-base](https://hub.docker.com/repository/docker/mrjeffapp/jenkins-pipeline-base)
- `mrjeffapp/jenkins-pipeline-base`
  - git
  - aws-cli
  - docker

### [jenkins-pipeline-node](https://hub.docker.com/repository/docker/mrjeffapp/jenkins-pipeline-node)
- `mrjeffapp/jenkins-pipeline-node:8`
- `mrjeffapp/jenkins-pipeline-node:12`

###  [jenkins-pipeline-java](https://hub.docker.com/repository/docker/mrjeffapp/jenkins-pipeline-java)
- `mrjeffapp/jenkins-pipeline-java:10`
- `mrjeffapp/jenkins-pipeline-java:11`
- `mrjeffapp/jenkins-pipeline-java:14`
 
## Examples
### Node pipeline
```groovy
pipeline {
    agent {
        docker { image 'mrjeffapp/jenkins-pipeline-node:8' }
    }

    stages {

        stage('Install') {
            steps {
                sh "yarn install"
            }
        }

    }

}
```

### Node pipeline with docker support
```groovy
pipeline {
    agent {
        docker {
            image 'mrjeffapp/jenkins-pipeline-node:12'
            args '--group-add docker -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    stages {

        stage('Install') {
            steps {
                sh "yarn install"
            }
        }

        stage('Build') {
            steps {
                sh "docker build ."
            }
        }

    }

}
```
