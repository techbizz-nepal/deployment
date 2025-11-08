#!/bin/bash

# Check if the service name is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <service_name>"
  exit 1
fi

if [ -z "$2" ]; then
  echo "Usage: $0 <platform_arch> | arm or amd"
  exit 1
fi

service_name="$1"
platform_arch="$2"
platform=""
tag=""
image_name=""
context_path=""

case "$platform_arch" in
  "amd")
    platform="linux/amd64/v2"
    ;;
  "arm")
    platform="linux/arm64/v8"
    ;;
  *)
    echo "Error: arch name '$platform_arch' not recognized."
    exit 1
    ;;
esac

# Define the mapping of service names to image names and context paths
case "$service_name" in
  "nginx")
    image_name="techbizz/nginx:latest-$platform_arch"
    context_path="/Users/apache/techbizz/bazzarify-docker/nginx"
    ;;
  "consumer")
    image_name="techbizz/consumer:latest-$platform_arch"
    context_path="/Users/apache/techbizz/bazzarify-consumer"
    ;;
  "vendor")
    image_name="techbizz/vendor:latest-$platform_arch"
    context_path="/Users/apache/techbizz/bazzarify-vendor"
    ;;
  # "webhook")
  #   image_name="techbizz/webhook:latest"
  #   context_path="/Users/apache/techbizz/webhook"
  #   ;;
  "frankenphp")
    image_name="techbizz/frankenphp:latest-$platform_arch"
    context_path="/Users/apache/techbizz/bazzarify-docker/src/backend"
    ;;
  "postgres")
    image_name="techbizz/postgres:latest-$platform_arch"
    context_path="/Users/apache/techbizz/bazzarify-docker/postgres"
    ;;
  "postgres18")
    image_name="techbizz/postgres18:latest-$platform_arch"
    context_path="/Users/apache/techbizz/bazzarify-docker/postgres18"
    ;;
  *)
    echo "Error: Service name '$service_name' not recognized."
    exit 1
    ;;
esac


# Build the Docker image
echo "Building Docker image: $image_name"
docker buildx build --platform="$platform" -t "$image_name" "$context_path"

if [ $? -eq 0 ]; then
  echo "Docker image '$image_name' built successfully."
  # if argument is given as amd push to docker hub
  if [ "$platform_arch" == "amd" ]; then
    docker push "$image_name"
    docker image rm $image_name
    echo "Docker image '$image_name' pushed to Docker Hub successfully."
  fi
else
  echo "Error building Docker image '$image_name'."
fi

exit 0