node('java11'){
    def projectName = "notification-api"

    cleanWs()
    envConfig()
    def branch = fixBranchName(PARAM_BRANCH)

    stage(name: 'Checkout') {
        timeout(time: 10, unit: "MINUTES") {
            echo "Executando checkout da branch $branch"
            checkoutFromGit("$branch")
        }
    }

    dir("applications/$projectName"){
        runPipeline(projectName, branch)
    }
}

def runPipeline(projectName, branch){
    def envProperties = getEnvironmentProperties(PARAM_ENVIRONMENT)

    stage(name: 'Clean') {
        timeout(time: 1, unit: "MINUTES") {
            executeShCommand("./gradlew clean")
        }
    }

    stage(name: 'Build') {
        timeout(time: 10, unit: "MINUTES") {
            executeShCommand("./gradlew build")
        }
    }

    stage(name: 'Release Image') {
        timeout(time: 10, unit: "MINUTES") {
            docker.withRegistry(envProperties["ecrUrl"], envProperties["credentials"]) {
                docker.build("${envProperties['name']}/$projectName").push(BUILD_NUMBER)
            }
        }
    }

//    stage(name: 'Deploy'){
//        ecsDeploy(branch, BUILD_NUMBER, projectName, PARAM_ENVIRONMENT.toLowerCase())
//    }
}

def fixBranchName(branch){
    if (branch.startsWith("origin/")) {
        def reg = ~/^origin\//
        branch = branch - reg
    }

    return branch
}


def envConfig(){
    def javaHome = tool 'java11'
    env.PATH = "${javaHome}/bin:${env.PATH}"
    env.JAVA_HOME = "${javaHome}"
    sh 'printenv'
}

def getEnvironmentProperties(environmentSelected){
    def qaProperties = [
            name: "qa",
            ecrUrl: "https://851759692963.dkr.ecr.us-east-1.amazonaws.com",
            credentials: "ecr:us-east-1:aws-tdc-qa",
    ]

    def environmentProperties = [
            qa: qaProperties
    ]
    def ret = environmentProperties[environmentSelected]

    if(!ret){
        throw new Exception("Invalid Environment Selected")
    }

    echo "Environment properties: $ret"
    return ret
}

def executeShCommand(command){
    echo "Executando comando SH: [$command]"
    sh command
}

def checkoutFromGit(branch) {
    checkout([$class           : 'GitSCM',
              branches         : [[name: "*/$branch"]],
              userRemoteConfigs: scm.userRemoteConfigs])
    sh "git checkout $branch"
    sh "chmod 777 -R ."
}

def ecsDeploy(appBranch, appVersion, projectName, environment) {
    def jobParameters = [
            [$class: "StringParameterValue", name: "PARAM_APP_VERSION", value: "$appVersion"],
            [$class: "StringParameterValue", name: "PARAM_APP_BRANCH", value: "$appBranch"],
            [$class: "StringParameterValue", name: "PARAM_APP_NAME", value: "$projectName"],
            [$class: "StringParameterValue", name: "PARAM_ENVIRONMENT", value: "$environment"],
    ]

    while (true) {
        try {
            timeout(time: 10, unit: "MINUTES") {
                build(
                        job: "/ecs-deploy",
                        wait: true,
                        parameters: jobParameters,
                        quietPeriod: 3
                )
            }

            return
        } catch (all) {
            echo "FAILURE[${++failure} of ${times}]: ${all}"

            if (failure >= times)
                throw all
        }
    }
}