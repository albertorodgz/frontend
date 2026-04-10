#!/bin/bash

# Move to the working directory
cd ../../frontend

# Get current version
echo "Getting current version from Helm Chart..."
CURRENT_VERSION=$(grep 'appVersion' helm-chart/Chart.yaml | awk '{print $2}')

# Set next version
echo "Setting next version..."
VERSION=$(echo $CURRENT_VERSION | awk -F. '{print ++$NF}')

# Build Docker image
echo "Building Docker image with version $VERSION..."
docker build -t webbook:$VERSION .

# Update Helm Chart
echo "Updating Helm Chart with version $VERSION..."
sed -i "s/tag: .*/tag: $VERSION/" helm-chart/values.yaml
sed -i "s/appVersion: .*/appVersion: $VERSION/" helm-chart/Chart.yaml

# Commit changes
echo "Committing changes and pushing to main"
git add helm-chart/values.yaml helm-chart/Chart.yaml
git commit -m "version: $VERSION"
git push origin HEAD:main
