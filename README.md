# Jenkins pipeline docker images

Docker images to use as an agent in [Jenkins pipelines](https://www.jenkins.io/doc/book/pipeline/docker/).

Based in the [CircleCI images project](https://github.com/circleci/circleci-images) and the [Bitbucket pipelines default image](https://hub.docker.com/r/atlassian/default-image/)

## Images

### Base
- `mrjeffapp/jenkins-pipeline-base`

### Node
- `mrjeffapp/jenkins-pipeline-node:8`
- `mrjeffapp/jenkins-pipeline-node:12`

### Java
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
