#!/bin/bash

# Check if the service name is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <service_name>"
  exit 1
fi

service_name="$1"
image_name=""
context_path=""

# Define the mapping of service names to image names and context paths
case "$service_name" in
  "nginx")
    image_name="techbizz/nginx:latest"
    context_path="/Users/apache/techbizz/bazzarify-docker/nginx"
    ;;
  "consumer")
    image_name="techbizz/consumer:latest"
    context_path="/Users/apache/techbizz/bazzarify-consumer"
    ;;
  "vendor")
    image_name="techbizz/vendor:latest"
    context_path="/Users/apache/techbizz/bazzarify-vendor"
    ;;
  "frankenphp")
    image_name="techbizz/frankenphp:latest"
    context_path="/Users/apache/techbizz/bazzarify-docker/src/backend"
    ;;
  *)
    echo "Error: Service name '$service_name' not recognized."
    exit 1
    ;;
esac

# Build the Docker image
echo "Building Docker image: $image_name"
docker build -t "$image_name" "$context_path"

if [ $? -eq 0 ]; then
  echo "Docker image '$image_name' built successfully."
else
  echo "Error building Docker image '$image_name'."
fi

exit 0