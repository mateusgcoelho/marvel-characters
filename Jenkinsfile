pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = 'mateusgcoelho/marvel-characters'
        IMAGE_VERSION = "${BUILD_NUMBER}"
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Teste de codigo') {
            steps {
                sh 'flutter pub get'
                sh 'flutter test'
            }
        }
        
        stage('Validacao de formatacao de codigo') {
            steps {
                sh 'dart format --set-exit-if-changed .'
            }
        }
        
        stage('Gerar build de aplicacao web') {
            steps {
                sh 'flutter build web'
            }
        }

        stage('Criação da imagem de docker') {
            steps {
                sh "docker build -t mateusgcoelho/marvel-characters:${IMAGE_VERSION} ."
            }
        }

        stage('Upload de imagem para DockerHub') {
            steps {
                script {
                    def credentials = credentials('docker-hub-credentials')
                    sh "docker login -u ${credentials.username} -p ${credentials.password}"
                }
                sh "docker push ${DOCKER_IMAGE_NAME}:${IMAGE_VERSION}"
                sh "docker tag ${DOCKER_IMAGE_NAME}:${IMAGE_VERSION} ${DOCKER_IMAGE_NAME}:latest"
                sh "docker push ${DOCKER_IMAGE_NAME}:latest"
            }
        }
        
        stage('Subindo container com versao de imagem') {
            steps {
                sh "docker run -d --name marvel-characters -p 80:80 ${DOCKER_IMAGE_NAME}:${IMAGE_VERSION}"
            }
        }
    }
}
