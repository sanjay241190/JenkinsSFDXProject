#!groovy
import groovy.json.JsonSlurperClassic
node {

    def BUILD_NUMBER=env.BUILD_NUMBER
    def RUN_ARTIFACT_DIR="tests/${BUILD_NUMBER}"
    def SFDC_USERNAME

    def HUB_ORG=env.HUB_ORG_DH
    def SFDC_HOST = env.SFDC_HOST_DH
    def JWT_KEY_CRED_ID = env.JWT_CRED_ID_DH
    def CONNECTED_APP_CONSUMER_KEY=env.CONNECTED_APP_CONSUMER_KEY_DH
    // Add this line in your Jenkins job script
    env.PATH = "C:\\Program Files\\sf\\bin;${env.PATH}"

    bat "sfdx --version"


    println 'KEY IS' 
    println JWT_KEY_CRED_ID
    println HUB_ORG
    println SFDC_HOST
    println CONNECTED_APP_CONSUMER_KEY

    
    //def toolbelt = tool 'toolbelt'
    
stage('checkout source') {
        // when running in multi-branch job, one must issue this command
        checkout scm
    }
withCredentials([file(credentialsId: JWT_KEY_CRED_ID, variable: 'jwt_key_file')]) {
        stage('Authenticate') {
            if (isUnix()) {
                rc = sh returnStatus: true, script: "sfdx force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile ${jwt_key_file} --setdefaultdevhubusername --instanceurl ${SFDC_HOST}"
            }else{
                 rc = bat returnStatus: true, script: "sfdx force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile \"${jwt_key_file}\" --setdefaultdevhubusername --instanceurl ${SFDC_HOST}"
            }
            if (rc != 0) { error 'hub org authorization failed' }

			println rc
	stage('Identify Delta')
	    // Identify changed files using Git
                def changedFiles = sh(returnStdout: true, script: "git diff --name-only origin/${env.BRANCH_NAME}...HEAD").trim()

	stage('Deploy Delta')
		// Deploy only changed files
                if (!changedFiles.isEmpty()) {
                    if (isUnix()) {
                        sh "sfdx force:source:deploy --sourcepath ${changedFiles}"
                    } else {
                        bat "sfdx force:source:deploy --sourcepath ${changedFiles}"
                    }
                } else {
                    echo "No changes detected. Skipping deployment."
                }
	      
		// need to pull out assigned username
		//	if (isUnix()) {
		//		rmsg = sh returnStdout: true, script: "sfdx force:mdapi:deploy -d manifest/. -u ${HUB_ORG}"
		//	}else{
			   //rmsg = bat returnStdout: true, script: "sf project deploy start  --source-dir force-app/. --target-org ${HUB_ORG}"
		//	   rmsg = bat returnStdout: true, script: "sf project deploy start  --source-dir force-app/. --target-org ${HUB_ORG}"
		//	}
			  
                //  printf rmsg
            //println('Hello from a Job DSL script!')
            //println(rmsg)
        }
    }
}

