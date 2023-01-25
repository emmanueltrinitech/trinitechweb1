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
                kubernetesDeploy(
                    kubeconfigId: 'kubeconfig',
                    configs: 'website3-kube.yml',
                    enableConfigSubstitution: true
                  )
                }
            }
        }
    }


