#!/bin/bash

# Set variables
IMAGE_NAME="nginx"
VERSION="1.25.3-alpine"

# Create placeholder HTML files
#echo "<html><body><h1>Welcome to index page</h1></body></html>" > index.html
#echo "<html><body><h1>Welcome to page1 </h1></body></html>" > page1.html

# Install curl in the Docker image
#echo -e "FROM nginx:latest\nRUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*" > Dockerfile
#echo -e "COPY index.html /usr/share/nginx/html" >> Dockerfile
#echo -e "COPY page1.html /usr/share/nginx/html" >> Dockerfile
#echo -e "EXPOSE 8080" >> Dockerfile
#echo -e `CMD ["nginx", "-g", "daemon off;"]` >>  Dockerfile

# Build Docker image
#docker build -t $IMAGE_NAME:$VERSION .
docker build --no-cache -t $IMAGE_NAME:$VERSION .

# Publish Docker image (replace 'your-registry' with your registry)
#docker tag $IMAGE_NAME:$VERSION your-registry/$IMAGE_NAME:$VERSION
#docker push your-registry/$IMAGE_NAME:$VERSION

# Output version
echo "Version: $VERSION"

