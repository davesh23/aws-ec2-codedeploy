#!/bin/bash
# Maintainer <Muhammad Asim quickbooks2018@gmail.com>
# Update route53 record & Services
# OS AmazonLinux2
# Note: Role must be attached for ECR image pull/push
# https://docs.amazonaws.cn/en_us/codedeploy/latest/userguide/application-revisions-appspec-file.html

# Docker Installation

yum install -y docker
systemctl start docker
systemctl enable docker

# Existing containers & Images Clean Up

docker rm -f "$(docker ps -aq)"  

docker rmi -f "$(docker images -aq)"

# docker run and Image

# docker login
$(aws ecr get-login --no-include-email --region us-east-1)

# API Service
TAG=`aws ecr describe-images --repository-name cloudgeeks-nginx --query 'sort_by(imageDetails,& imagePushedAt)[-1].imageTags[0]'  --region us-east-1 | awk -F '["]' '{print $2}'`

export TAG

docker run --name cloudgeeks-ca-nginx -p 80:80 --restart unless-stopped -d 817333706759.dkr.ecr.us-east-1.amazonaws.com/cloudgeeks-nginx:"$TAG"

# END