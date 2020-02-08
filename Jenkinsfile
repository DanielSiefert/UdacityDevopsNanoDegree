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
                    dockerImage = docker.build("danielsiefert/devops-capstone:$BUILD_NUMBER")
                    docker.withRegistry('', dockerhubCredentials) {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Rolling Deploy on AWS EKS') {
            steps {
                    withAWS(credentials: 'awsCreds', region: 'us-east-1') {
                            sh 'curl "https://d1vvhvl2y92vvt.cloudfront.net/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"'
                            sh 'unzip awscliv2.zip'
                            sh 'sudo ./aws/install'
                            sh 'aws eks --region us-east-1 update-kubeconfig --name my-travel-blog'
                            sh 'kubectl apply -f my-travel-blog-delpoy.yaml'
                    }
                    
            }
        }        
    }
}
