#!/bin/bash
set -e


export SHORT_COMMIT_ID=$(git rev-parse --short HEAD || echo "local")
export IMAGE_TAG="build-${SHORT_COMMIT_ID}"
export ECR_IMAGE_REPO_NAME="springboot-sample"
export AWS_DEFAULT_REGION="us-east-1"
export ECR_AWS_ACCOUNT_ID="123456789012"  # dummy
export IMAGE_URI="${ECR_AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${ECR_IMAGE_REPO_NAME}:${IMAGE_TAG}"

mkdir -p build

echo "${SHORT_COMMIT_ID}" > build/version.txt
echo "${IMAGE_TAG}" > build/build_tag.txt
echo "${IMAGE_URI}" > build/image_uri.txt

# Build Java project
chmod +x mvnw
./mvnw clean package -DskipTests

echo "== Copy jar file to Docker build folder =="
mkdir -p docker/build
cp target/*.jar docker/build/


# Docker build & push
cd /docker/
docker build -t ${IMAGE_URI} .
echo "Image built: ${IMAGE_URI}"

# Push to ECR (mock for now)
echo "Pretending to push to: ${IMAGE_URI}"
# docker push ${IMAGE_URI}

cd ..
