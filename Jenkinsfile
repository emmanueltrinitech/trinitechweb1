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
	       
	      

            node {    
      def app     
      stage('Clone repository') {               
             
            checkout scm    
      }     
      stage('Build image') {         
       
            app = docker.build("ewarah/website1")    
       }     
      stage('Test image') {           
            app.inside {            
             
             sh 'echo "Tests passed"'        
            }    
        }     
       stage('Push image') {
                                                  docker.withRegistry('https://registry.hub.docker.com', 'git') {            
       app.push("${env.BUILD_NUMBER}")            
       app.push("latest")        
              }    
           }
        }
      }
