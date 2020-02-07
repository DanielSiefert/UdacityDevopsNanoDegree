pipeline {
    environment {
        dockerhubCredentials = 'dockerhub'
    }
    agent any
    stages {
        stage('Add Dockerfile linter - hadolint') {
              steps {
                  sh 'wget https://github.com/hadolint/hadolint/releases/download/v1.17.4/hadolint-Linux-x86_64'
                  sh 'cp hadolint-Linux-x86_64 hadolint'
                  sh 'chmod 755 hadolint'
              }
        }
        stage('Lint Dockerfile') {
              steps {
                  sh './hadolint Dockerfile'
              }
        }
        stage('Create gzip of Blog') {
            steps {
                sh 'tar -zcf travel-blog-site.tar.gz -C $PWD/travel-blog-site .'
                }
        }
        stage('Build & Push to dockerhub') {
            steps {
                script {
                    dockerImage = docker.build("danielsiefert/devops_capstone:$BUILDID")
                    docker.withRegistry('', dockerhub) {
                        dockerImage.push()
                    }
                }
            }
        }        
    }
}
