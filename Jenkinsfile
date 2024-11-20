pipeline {
    agent { label 'agent1' }

    environment {
        GIT_REPO = 'https://github.com/Nimaa31/jenkins.git'
        GIT_BRANCH = 'master'  
        DOCKER_IMAGE = 'jenkins/jenkins:lts'
	GIT_MAIL = 'amin.eddine31@icloud.com' 
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
                    // Authentification Docker Hub avec les credentials
                    withCredentials([
			usernamePassword(
			credentialsId: 'dockerhub-credentials', 
			usernameVariable: 'DOCKER_USER', 
			passwordVariable: 'DOCKER_PASS'
		)
		]){
                        sh '''
			docker login -u "$DOCKER_USER"  -p "$DOCKER_PASS"  

                        docker build -t ${DOCKER_IMAGE} .   
                       # docker push ${DOCKER_IMAGE}  
                        '''
                    }
                }
            }
        }

        stage('Push to GitHub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'GIT', usernameVariable: 'GIT_USER', passwordVariable: 'GIT_TOKEN')]) {
                        sh '''
                        git config --global user.name "${GIT_USER}"
                        git config --global user.email "${GIT_MAIL}"

                        if ! git diff-index --quiet HEAD --; then
			git add .
                        git commit -m "Automated commit from Jenkins"
                        git push https://${GIT_USER}:${GIT_TOKEN}@github.com/Nimaa31/jenkins.git
		
			else
				echo "No changes to commit"
                	fi
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
