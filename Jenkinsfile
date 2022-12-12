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

                withCredentials([usernamePassword(credentialsId: 'centos33_rsa_key', usernameVariable: 'USERNAME', passwordVariable: 'USERPASS')]) {

                    sshPublisher(

                        failOnError: true,

                        publishers: [

                            sshPublisherDesc(

                                configName: 'staging',

                                sshCredentials: [

                                    username: '$USERNAME',

                                    encryptedPassphrase: "$USERPASS"

                                ], 

                                transfers: [

                                sshTransfer(

                                sourceFiles: 'trinitech-web/website1.zip',

                                removePrefix: 'trinitech-web/',

                                remoteDirectory: '/tmp'   
                                

                               )
                               
                           ]
                     )

                 ]

            )

        }

     }

   }

 }

}
