pipeline {
    agent any

    environment {
        DOCKER_USERNAME = credentials('docker-hub-credentials').username
        DOCKER_PASSWORD = credentials('docker-hub-credentials').password
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Validação de formatação de código') {
            steps {
                sh 'dart format --set-exit-if-changed .'
            }
        }

        stage('Teste de código') {
            steps {
                sh 'flutter test'
            }
        }
        
        stage('Gerar build de aplicação web') {
            steps {
                sh 'flutter build web'
            }
        }

        stage('Criação da imagem de docker') {
            steps {
                sh 'docker buildx build -t mateusgcoelho/marvel-characters .'
            }
        }

        stage('Upload de imagem para DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}"
                    sh 'docker push mateusgcoelho/marvel-characters'
                }
            }
        }
    }
}
