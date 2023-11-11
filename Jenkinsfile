pipeline {
    agent any
    
    stages {
        stage('Build docker image') {
            steps {
                sh 'docker build -t marvel-characters:latest .'
            }
        }
        stage('Run docker container'){
            steps{
                sh 'docker run -p 80:80 -d marvel-characters:latest'
            }
        }
    }
}