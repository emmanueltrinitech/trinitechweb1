pipeline {

       agent any

       stages {

              stage('Build') {

                     steps {
			   
                               
                              

                             echo 'Running build automation'

                             sh './gradlew build --no-daemon'

                             archiveArtifacts artifacts: 'trinitech-web/website1.zip'

		      }

		

		}
	       
	      

              stage('Build Docker Image') {
                  when {
                    branch 'branch3'
               }
	   
      	       
               steps {
		    
                script {
		   warnError(message: "${STAGE_NAME} stage was unstable.", catchInterruptions: false) {
			   dockerImage = docker.build("ewarah/website2")
                    
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
		   warnError(message: "${STAGE_NAME} stage was unstable.", catchInterruptions: false) {
                    docker.withRegistry('https://registry.hub.docker.com','docker_hub_login') {
                        dockerImage.push("${env.BUILD_NUMBER}")
                        dockerImage.push("latest")
		    }
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
                        sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$prod_ip \"docker pull ewarah/website2:${env.BUILD_NUMBER}\""
                        try {
                            sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$prod_ip \"docker stop website2\""
                            sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$prod_ip \"docker rm website2\""
                        } catch (err) {
                            echo: 'caught error: $err'
                        }
                        sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$prod_ip \"docker run -tid -p 6222:22 -p 6083:80 --name=website2 --tmpfs -v /sys/fs/cgroup:/sys/fs/cgroup:ro  --restart always ewarah/website2:${env.BUILD_NUMBER} /bin/bash\""
                    }
                }
            }
        }
    }
}


