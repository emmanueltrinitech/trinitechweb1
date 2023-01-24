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
			   dockerImage = docker.build("ewarah/website3")
                    
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
                        sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no -p 5022 $USERNAME@$prod_ip \"docker pull ewarah/website3:${env.BUILD_NUMBER}\""
                        try {
                            sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no -p 5022 $USERNAME@$prod_ip \"docker stop website3\""
                            sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no -p 5022 $USERNAME@$prod_ip \"docker rm website3\""
                        } catch (err) {
                            echo: 'caught error: $err'
                        }
                        sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no -p 5022 $USERNAME@$prod_ip \"docker run -tid -p 6322:22 -p 6183:80 -p 9197:9090 -p 8189:8080 --name=website3 --privileged --tmpfs /run -v /sys/fs/cgroup:/sys/fs/cgroup:ro  --restart always ewarah/website3:${env.BUILD_NUMBER} /usr/sbin/init\""
                    }
                }
            }
        }
    }
}


