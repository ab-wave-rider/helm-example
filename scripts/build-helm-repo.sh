#!/bin/bash

# Build Helm repository locally
echo "Building Helm repository..."

# Package the chart
helm package .

# Generate index.yaml
helm repo index . --url https://ab-wave-rider.github.io/helm-example

echo "Helm repository built successfully!"
echo "Files created:"
ls -la *.tgz index.yaml 2>/dev/null || echo "No files found"

echo ""
echo "To test locally:"
echo "helm repo add local-test file://$(pwd)"
echo "helm repo update"
echo "helm install example-app local-test/example-app" 