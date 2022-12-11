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

              stage('DeployToStaging') {

                    when {  

                             branch 'stream8-test'

                    }      

                    script {
                        sshPublisher(

                        failOnError: true,

                        continueOnError: false,

                        publishers: [

                            sshPublisherDesc(

                                configName: "${env.SSH_CONFIG_NAME}",
                                verbose: true
                                ), 
                                transfers: [

                                sshTransfer(

                                sourceFiles: 'trinitech-web/website1.zip',

                                removePrefix: 'trinitech-web/',

                                remoteDirectory: '/tmp'   
                                
                                execCommand: 'echo zip file copied'


                               
                           ])
                       ])

               }



          }



    }

}
