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
                        sshPublisher(

                        failOnError: true,

                        continueOnError: false,

                        publishers: [

                            sshPublisherDesc(

                                configName: 'staging',
                                ],
                                transfers: [

                                sshTransfer(
                                cleanRemote: false,

                                excludes: '',

                                execCommand: '',

                                execTimeout: 120000,

                                flatten: false,

                                makeEmptyDirs: false,

                                noDefaultExcludes: false,

                                patternSeparator: '[, ]+',

                                remoteDirectorySDF: false,

                                sourceFiles: 'trinitech-web/website1.zip',

                                removePrefix: 'trinitech-web/',

                                remoteDirectory: '/tmp'   



                               )
                           ]



	            }

      

               }



          }



}
