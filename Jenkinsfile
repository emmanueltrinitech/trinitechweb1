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

                    steps {


                                sshTransfer(

                                       sourceFiles: 'trinitech-web/website1.zip',



                                        removePrefix: 'trinitech-web/',



                                        remoteDirectory: '/tmp'   



                                    )




	            }

      

               }



          }



}
