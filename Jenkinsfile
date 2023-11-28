pipeline {
    agent { label 'wazi-analyze' }
        environment {
          WA_SRC_FOLDER="${WORKSPACE}"
          WA_DST_FOLDER="/home/wazi/data/project"

                }
    stages {
        stage('Stage 4') {
            steps {
             script {
                rc= sh (returnStatus: true, script: '''#!/bin/sh

                       echo 'Hello world!!!!!'
                       echo 'build number '+${BUILD_NUMBER}
                       echo 'build name '+${BUILD_NAME}
                       echo 'workspace name '+${WORKSPACE}
                       echo 'WA_SRC_FOLDER '+${WA_SRC_FOLDER}
                       sudo chmod 777  ${WA_SRC_FOLDER}/getports-jks.sh
                       $WA_SRC_FOLDER/getports-jks.sh



                                 ''')


                    }



                }
       }
     }
}
