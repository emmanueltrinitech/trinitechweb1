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

                            branch 'jenkins-branch'

                    }      
                steps {


                    sshPublisher(

                        failOnError: true, continueOnError: false,

                        publishers: [

                            sshPublisherDesc(

                                configName: 'aws-rhel',
                                verbose: true,

                                transfers: [

                                sshTransfer(

                                sourceFiles: 'trinitech-web/*.zip',

                                removePrefix: 'trinitech-web/',

                                remoteDirectory: '/tmp',   
                                
                                 execCommand:'mv /tmp/website1.zip /tmp/website1-version-`date +%m-%d-%Y:%H:%M:%S`.zip',

                               )
                               
                           ]

                        )
                   ]
               )
            }
          }
      }
    }
