pipeline {



       agent any



       stages {



              stage('Build') {



                     steps {



                            echo 'Running build automation'



                             sh './gradlew build --no-daemon'



                             archiveArtifacts artifacts: 'trinitech-web/emmanuel34.zip'



		      }



		}

              stage('DeployToStaging') {

                    when {  

                            branch 'branch4'

                    }      
                steps {


                    sshPublisher(

                        failOnError: true, continueOnError: false,

                        publishers: [

                            sshPublisherDesc(

                                configName: 'staging',
                                verbose: true,

                                transfers: [

                                sshTransfer(

                                sourceFiles: 'trinitech-web/*.zip',

                                removePrefix: 'trinitech-web/',

                                remoteDirectory: '/tmp',   
                                

                               )
                               
                           ]

                        )
                   ]
               )
            }
          }
      }
    }
