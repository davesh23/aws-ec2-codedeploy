# aws-ecr-codebuild-codedeploy-codepipeline 

https://cloudgeeks.ca


# STEPS

# 1. Create a Role for EC2 with ECR access ---> AmazonEC2ContainerRegistryPowerUser + AmazonEC2RoleforAWSCodeDeploy

# 2. Create Launch Configuration ---> ami-0947d2ba12ee1ff75

# 3. Create AS Group

# 4. s3 bucket ---> put .zip

# 5. codedeploy app + group + role ---> AWSCodeDeployRole

# 6. codepipeline