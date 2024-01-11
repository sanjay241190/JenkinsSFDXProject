#!groovy
import groovy.json.JsonSlurperClassic
node {

    def BUILD_NUMBER=env.BUILD_NUMBER
    def RUN_ARTIFACT_DIR="tests/${BUILD_NUMBER}"
    def SFDC_USERNAME
    def from_commitId="310a22a0b5e82eed1e446838f34a4e5d79f3040a"
    def HUB_ORG=env.HUB_ORG_DH
    def SFDC_HOST = env.SFDC_HOST_DH
    def JWT_KEY_CRED_ID = env.JWT_CRED_ID_DH
    def CONNECTED_APP_CONSUMER_KEY=env.CONNECTED_APP_CONSUMER_KEY_DH
    def fileName = 'null'
    def changedFileNames = 'null'
    env.BRANCH_NAME = "main"
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
    
                script {
                    // Retrieve the head commit ID
                    def commitId = bat(script: 'git rev-parse HEAD', returnStdout: true).trim()
                    println "Head Commit ID: ${commitId}"

                    // Now you can use the 'commitId' variable in your further steps or actions
                    // For example, you might want to pass it to other scripts or use it in your build process.
                
            }
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
	stage('Identify Delta'){
	    // Identify changed files using Git
                def changedFiles = bat(returnStdout: true, script: "git diff --name-only ${from_commitId}...HEAD").trim()
		                   
                // Extract only file names using basename
                       changedFileNames = changedFiles.split('\n').collect { filePath ->
                        // Extract file name using basename
                        fileName = filePath.tokenize('/').last()
                        
                        // Print the file name (optional)
                        echo "File Name: ${fileName}"

                        // Return the file name
                        fileName
		echo "Changed File Names: ${changedFileNames.join(', ')}"
                }
		  }
	
		// Deploy only changed files
                if (!fileName.isEmpty()) {
                    if (isUnix()) {
                        rmsg = sh returnStdout: true, script: "sf project deploy start  --sourcepath ${changedFileNames.join(', ')} --target-org ${HUB_ORG}"
                    } else {
                 	rmsg = bat returnStdout: true, script: "sf project deploy start  --sourcepath ${changedFileNames.join(', ')} --target-org ${HUB_ORG}"
                    }
                } else {
                    echo "No changes detected. Skipping deployment."
                }
	      
			  
            printf rmsg
            println('Hello from a Job DSL script!')
            println(rmsg)
	
                    
	
	}
    }
}
