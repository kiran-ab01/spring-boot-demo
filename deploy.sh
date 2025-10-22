#!/bin/bash
set -e

cd ${CODEBUILD_SRC_DIR:-.}

IMAGE_BUILD_VERSION=$(cat build/version.txt)
BUILD_TAG=$(cat build/build_tag.txt)
IMAGE_URI=$(cat build/image_uri.txt)
ENV_NAME="dev"
IMAGE_TAG="${ENV_NAME}-${IMAGE_BUILD_VERSION}"

echo "Deploying ${IMAGE_URI} as ${IMAGE_TAG}"

# Simulate Lambda ZIP package
mkdir -p lambda/package
cd lambda/package
unzip ../../docker/build/*.jar -d .
zip -r lambda-function.zip .
cp lambda-function.zip ../build/
cd ../../

# Terraform deploy mock
cd terraform
echo "Simulating terraform init, plan, apply..."
touch terraform_plan
cd ..

echo "Deployment complete!"
