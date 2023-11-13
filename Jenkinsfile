pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Flutter Test') {
            steps {
                sh 'flutter pub get'
                sh 'flutter test'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t mateusgcoelho/marvel-characters .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}"
                    sh 'docker push mateusgcoelho/marvel-characters'
                }
            }
        }
    }
}
