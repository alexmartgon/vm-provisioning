pipeline {

    //Use any jenkins agent available (master or slaves)
    agent any

    stages {
        
        stage("set-variables"){
            environment {
                VSPHERE_SERVER = credentials('vsphere-hp')
                //git_creds = credentials('AlexmartgonAccessToken')
                VSPHERE_USER = credentials('esxi-alejandro-role')
            }
            //All the terraform scripts here, make it somehow able to intake a variable to pass skip this step or not
            steps {
                echo 'Setting up environment for terraform'
                sh('export TF_VAR_vsphere_server=$VSPHERE_SERVER')
                sh('export TF_VAR_vsphere_user=$VSPHERE_USER_USR')
                sh('export TF_VAR_vsphere_password=$VSPHERE_USER_PSW')
            }
        }

        stage("plan"){
            // environment {
            // }
            //All the yarn installs and probably even ansible script triggers here
            steps {
                echo 'Planning Terraform script'
                sh('terraform init')
                sh('terraform plan -input=false -out tfplan')
                sh('terraform show -no-color tfplan') //> tfplan.txt
            }
        }

        stage("apply"){

            steps{
                echo 'Provisioning the VMs' 
            }
        }

        stage("clean-up"){

            steps{
                echo 'Cleaning up environment variables.'
                //sh('unset TF_VAR_vsphere_server TF_VAR_vsphere_user TF_VAR_vsphere_password')
            }
        }

    }

}
