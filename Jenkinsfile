pipeline {
    agent any

    environment {
        PRIVATE_KEY_PATH = "${HOME}/.ssh/mykey.pem"
    }

    stages {

        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    sh '''
                        terraform init
                        rm -f .terraform/terraform.tfstate.lock.info || true
                        terraform apply -auto-approve -var "key_name=mykey"
                    '''
                }
            }
        }

        stage('Ansible Deploy') {
            steps {
                dir('ansible') {
                    script {
                        def ip = sh(
                            script: "terraform -chdir=../terraform output -raw web_server_ip",
                            returnStdout: true
                        ).trim()

                        writeFile(
                            file: 'inventory.ini',
                            text: "[web]\\n${ip} ansible_user=ec2-user ansible_ssh_private_key_file=${env.PRIVATE_KEY_PATH}"
                        )
                    }
                    sh 'ansible-playbook -i inventory.ini playbook.yml'
                }
            }
        }

        stage('Show URL') {
            steps {
                script {
                    def ip = sh(
                        script: "terraform -chdir=terraform output -raw web_server_ip",
                        returnStdout: true
                    ).trim()
                    echo "Web application is live at http://${ip}"
                }
            }
        }
    }
}




