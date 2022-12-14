node('terraform'){
    cleanWs()
    def terraform = "${tool 'terraform'}/terraform"
    def modulesPath = "infrastructure/modules/services/ecs-ec2-backend-app/"


    stage(name: 'Checkout'){
        echo 'Cloning repository'
        checkoutFromGit("$PARAM_APP_BRANCH")
    }
    
    stage(name: 'Prepare Environment'){
        executeShCommand("cp -R applications/$PARAM_APP_NAME/devops/ecs/${PARAM_ENVIRONMENT.toLowerCase()}/* $modulesPath ")
    }

    def credentials = "aws-tdc-qa"

    stage(name: 'Destroy'){
        timeout(time: 30, unit: "MINUTES"){
            dir(modulesPath){
                executeShCommand('terraform  init -no-color -backend-config=backend.conf')
                executeShCommand("terraform apply --destroy -no-color -auto-approve -var image_version=destroy")
            }
        }
    }
}

def executeShCommand(command){
    echo "Execute SH Command: $command"
    sh command
}

def checkoutFromGit(branch) {
    checkout([$class           : 'GitSCM',
              branches         : [[name: "*/$branch"]],
              userRemoteConfigs: scm.userRemoteConfigs])
    sh "git checkout $branch"
    sh "chmod 777 -R ."
}