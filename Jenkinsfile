pipeline {
  agent {
    docker {
      image 'circleci/buildpack-deps:stretch'
    }

  }
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

  }
}