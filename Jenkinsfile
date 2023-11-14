pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = 'mateusgcoelho/marvel-characters'
        IMAGE_VERSION = "${BUILD_NUMBER}"
    }
    
    stages {
        stage('Valida dependencias') {
            steps {
                sh 'flutter pub get'
            }
        }
        
        stage('Teste de codigo') {
            steps {
                sh 'flutter test'
            }
        }
        
        stage('Validacao de formatacao de codigo') {
            steps {
                sh 'dart format --set-exit-if-changed .'
            }
        }
        
        stage('Login em DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', passwordVariable: 'DOCKERHUB_PASSWORD', usernameVariable: 'DOCKERHUB_USERNAME')]) {
                    sh "docker login -u ${DOCKERHUB_USERNAME} -p ${DOCKERHUB_PASSWORD}"
                }
            }
        }

        stage('Criação da imagem de docker') {
            steps {
                sh "docker build -t ${DOCKER_IMAGE_NAME}:${IMAGE_VERSION} ."
            }
        }

        stage('Upload versão da imagem para DockerHub') {
            steps {
                sh "docker push ${DOCKER_IMAGE_NAME}:${IMAGE_VERSION}"
            }
        }


        stage('Upload versão latest da imagem para DockerHub') {
            steps {
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
