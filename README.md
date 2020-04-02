# Jenkins pipeline docker images

## Images

### Base
- `mrjeffapp/jenkins-pipeline-base`

### Node
- `mrjeffapp/jenkins-pipeline-node8`
- `mrjeffapp/jenkins-pipeline-node12`

### Java
- `mrjeffapp/jenkins-pipeline-java11`
 
## Examples
### Node pipeline
```groovy
pipeline {
    agent {
        docker { image 'mrjeffapp/jenkins-pipeline-node8' }
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
            image 'mrjeffapp/jenkins-pipeline-node12'
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
