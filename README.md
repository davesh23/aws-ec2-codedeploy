# aws-ecr-codebuild-codedeploy-codepipeline 

https://cloudgeeks.ca


# STEPS

# 1. Create a Role for EC2 with ECR access ---> AmazonEC2ContainerRegistryPowerUser + AmazonEC2RoleforAWSCodeDeploy

# 2. Create Launch Configuration ---> ami-0947d2ba12ee1ff75

# 3. Create AS Group
 
# 4. s3 bucket ---> put .zip  ---> update .zip with ECR URI ---> eg.ECR REPO NAME cloudgeeks-nginx ---> ECR REPO URI 286601674019.dkr.ecr.us-east-1.amazonaws.com/cloudgeeks-nginx

# 5.A PUSH DOCKER IMAGE TO AWS with GITHUBACTIONS ---> aws-ecr-codedeploy/.github/workflows/ecr.yml

# 5.B codedeploy app + group + role ---> AWSCodeDeployRole

# 6. codepipeline
