pipeline {

       agent any
	
	options {
        skipStagesAfterUnstable()
    }

       stages {

              stage('Build') {

                     steps {
			   
                               
                              

                             echo 'Running build automation'

                             sh './gradlew build --no-daemon'

                             archiveArtifacts artifacts: 'trinitech-web/website1.zip'

		      }

		

		}
	       
	      

              stage('Build Docker Image') {
		 steps{
	           script {
                    docker.build("ewarah/website1")
	        }
	      }
	     }	      
	       stage('Test image') {
	       steps{
		 script{
                     inside {
                     sh 'echo $(curl localhost:8080)'
		        
                    }
                }
            }
       
	 }   
           
        stage('Push Docker Image') {
            when {
                branch 'branch3'
            }
            steps {
	          
                script {
		  
                    docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_login') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
		
		  }
                }
            }
        }
	
        stage('DeployToProduction') {
            when {
                branch 'branch3'
            }
            steps {
                input 'Deploy to Production?'
                milestone(1)
                withCredentials([usernamePassword(credentialsId: 'webserver_login', usernameVariable: 'USERNAME', passwordVariable: 'USERPASS')]) {
                    script {
                        sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$prod_ip \"docker pull ewarah/website1:${env.BUILD_NUMBER}\""
                        try {
                            sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$prod_ip \"docker stop website1\""
                            sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$prod_ip \"docker rm website1\""
                        } catch (err) {
                            echo: 'caught error: $err'
                        }
                        sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$prod_ip \"docker run --restart always --name website1 -p 8484:8484 -d ewarah/website1:${env.BUILD_NUMBER}\""
                    }
                }
            }
        }
    }
}


