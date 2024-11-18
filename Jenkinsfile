pipeline {
    agent any

    environment {
        GIT_REPO = 'https://github.com/Nimaa31/jenkins.git'
        GIT_BRANCH = 'main'
        COMPOSE_FILE = 'docker-compose.yml'
        DOCKER_IMAGE = 'dockerhub_user/jenkins-image' // Remplacez par votre nom d'image Docker Hub
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: "${GIT_BRANCH}", url: "${GIT_REPO}"
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh '''
                        docker login -u ${DOCKER_USER} -p ${DOCKER_PASS}
                        docker build -t ${DOCKER_IMAGE}:latest .
                        docker push ${DOCKER_IMAGE}:latest
                        '''
                    }
                }
            }
        }

        stage('Docker Compose Up') {
            steps {
                script {
                    sh 'docker-compose -f ${COMPOSE_FILE} up -d'
                }
            }
        }

        stage('Push to GitHub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'amin', usernameVariable: 'GIT_USER', passwordVariable: 'GIT_TOKEN')]) {
                        sh '''
                        git config --global user.name "Nimaa31"
                        git config --global user.email "amin.eddine31@icloud.com"
                        git add .
                        git commit -m "Automated commit from Jenkins"
                        git push https://${GIT_USER}:${GIT_TOKEN}@github.com/Nimaa31/jenkins.git
                        '''
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
    }
}
