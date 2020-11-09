#!/bin/bash
# Codedeploy-Agent for ec2
# Region: us-east-1
# OS: AmazonLinux2
# https://docs.aws.amazon.com/codedeploy/latest/userguide/codedeploy-agent-operations-install-linux.html
# https://docs.aws.amazon.com/codedeploy/latest/userguide/codedeploy-agent.html
# https://docs.aws.amazon.com/codedeploy/latest/userguide/instances-ec2-configure.html

# script in zip ---> must be dos2unix
# https://askubuntu.com/questions/304999/not-able-to-execute-a-sh-file-bin-bashm-bad-interpreter


yum update -y

yum install ruby -y

yum install wget -y 

cd /home/ec2-user

wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install

chmod +x ./install

./install auto

./install auto -v releases/codedeploy-agent-###.rpm

service codedeploy-agent status

service codedeploy-agent start

# Docker Installation

yum install -y docker
systemctl start docker
systemctl enable docker



## END




