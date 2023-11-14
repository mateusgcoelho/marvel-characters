pipeline {
    agent any

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
                script {
                    def credentials = credentials('docker-hub-credentials')
                    sh "docker login -u ${credentials.username} -p ${credentials.password}"
                    sh 'docker push mateusgcoelho/marvel-characters'
                }
            }
        }
    }
}
