# Example App Helm Chart

A Helm chart for deploying an example application with a custom welcome message on Kubernetes with ArgoCD.

## Overview

This Helm chart serves as an **example template** for teams to use as a starting point when creating their own Helm charts. It demonstrates best practices for Kubernetes deployments with ArgoCD and includes various infrastructure features commonly used in production environments.

The chart deploys a simple example application that displays a welcome message when accessed. This makes it perfect for:
- Learning Helm chart development
- Testing Kubernetes deployments
- Demonstrating ArgoCD workflows
- Providing a foundation for more complex applications

## Features

- ✅ AWS ALB Ingress
- ✅ Shared Load Balancer  
- ✅ SSL/TLS Support
- ✅ WAF Protection
- ✅ Health Checks
- ✅ Standalone Helm Chart
- ✅ AWS Secrets Manager Integration
- ✅ Environment Variables from Secrets
- ✅ Deployed with ❤️ using ArgoCD

## Welcome Message

When deployed, the application displays:

```
🎉 Welcome to Example Helm Chart App! 🚀
This is a fun example application running on Kubernetes with ArgoCD!
Environment: Development
Features:
✅ AWS ALB Ingress
✅ Shared Load Balancer
✅ SSL/TLS Support
✅ WAF Protection
✅ Health Checks
✅ Standalone Helm Chart
✅ AWS Secrets Manager Integration
✅ Environment Variables from Secrets

My supersecret word is: [from AWS Secrets Manager]

Deployed with ❤️ using ArgoCD

Environment: Development
Version: 1.0.0
Database URL: [from AWS Secrets Manager]
API Key: [from AWS Secrets Manager]
Feature Flags: [from AWS Secrets Manager]
```

## Installation

### Prerequisites

- Kubernetes cluster
- Helm 3.x
- ArgoCD (for GitOps deployment)

### Getting Started

This chart is designed to be **copied and customized** for your specific use case. To use it as a template:

1. **Fork or copy** this chart to your own repository
2. **Customize** the `values.yaml` for your application
3. **Modify** the welcome message and container configuration
4. **Add** your specific requirements (ingress, secrets, etc.)
5. **Deploy** using your preferred method

### Using Helm

```bash
# Install the chart
helm install example-app ./

# Upgrade existing installation
helm upgrade example-app ./

# Uninstall
helm uninstall example-app
```

### Using ArgoCD

1. Add this repository to your ArgoCD application
2. Configure the application to use this Helm chart
3. Deploy through ArgoCD UI or CLI

## Configuration

The following table lists the configurable parameters of the chart and their default values.

| Parameter | Description | Default |
|-----------|-------------|---------|
| `name` | Application name | `example-app` |
| `image` | Container image | `hashicorp/http-echo:latest` |
| `replicas` | Number of replicas | `1` |
| `port` | Container port | `8080` |
| `entrypoint` | Container entrypoint | `sh` |
| `args` | Container arguments | Custom welcome message script |

## Values

Key values in `values.yaml`:

```yaml
name: example-app
image: hashicorp/http-echo:latest
entrypoint: "sh"
args: '"-c", "echo \"🎉 Welcome to Example Helm Chart App! 🚀\nThis is a fun example application running on Kubernetes with ArgoCD!\nEnvironment: Development\nFeatures:\n✅ AWS ALB Ingress\n✅ Shared Load Balancer\n✅ SSL/TLS Support\n✅ WAF Protection\n✅ Health Checks\n✅ Standalone Helm Chart\n✅ AWS Secrets Manager Integration\n✅ Environment Variables from Secrets\n\nMy supersecret word is: $supersecret\n\nDeployed with ❤️ using ArgoCD\" && echo \"Environment: $APP_ENVIRONMENT\" && echo \"Version: $APP_VERSION\" && echo \"Database URL: $database_url\" && echo \"API Key: $api_key\" && echo \"Feature Flags: $feature_flags\" && sleep infinity"'
port: 8080
replicas: 1

# Environment variables
containerEnv:
  - name: APP_ENVIRONMENT
    value: "Development"
  - name: APP_VERSION
    value: "1.0.0"

# AWS Secrets Manager integration
envSecrets:
  - k8s_secret_name: app-secrets
    aws_secret_name: /hypr/example-app/secrets
    keys:
      - "database_url"
      - "api_key"
      - "feature_flags"
      - "supersecret"
```

## Customization

### Changing the Welcome Message

To customize the welcome message, modify the `args` parameter in `values.yaml`:

```yaml
args: '"-c", "echo \"Your custom message here\" && sleep infinity"'
```

### Adding Ingress

Uncomment and configure the ingress section in `values.yaml`:

```yaml
ingress:
  group_name: "apps"
  hosts:
    - your-domain.com
  public: true
```

### Using AWS Secrets Manager

This template includes AWS Secrets Manager integration. Configure secrets in `values.yaml`:

```yaml
envSecrets:
  - k8s_secret_name: app-secrets
    aws_secret_name: /hypr/example-app/secrets
    keys:
      - "database_url"
      - "api_key"
      - "feature_flags"
      - "supersecret"
```

The secrets will be automatically mounted as environment variables in your pods.

### Resource Limits

Configure resource requests and limits:

```yaml
resources:
  requests:
    memory: 128Mi
    cpu: 100m
  limits:
    memory: 256Mi
    cpu: 200m
```

## Architecture

The chart creates the following Kubernetes resources:

- **Deployment**: Runs the example application container
- **Service**: Exposes the application on port 80
- **ConfigMap**: Contains any additional files (if configured)
- **NetworkPolicy**: Controls network access (if enabled)
- **PriorityClass**: Sets pod priority (if configured)

## Troubleshooting

### Check Pod Status

```bash
kubectl get pods -l app.kubernetes.io/name=example-app
```

### View Logs

```bash
kubectl logs -l app.kubernetes.io/name=example-app
```

### Check Service

```bash
kubectl get svc example-app
```

## Using This Template

### For New Projects

When starting a new Helm chart project:

1. **Copy this template** to your project directory
2. **Update `Chart.yaml`** with your application details
3. **Modify `values.yaml`** to match your application requirements
4. **Customize templates** as needed for your specific use case
5. **Test locally** before deploying to production

### Template Structure

This template includes:
- **Deployment**: Basic Kubernetes deployment configuration
- **Service**: Service exposure configuration
- **Ingress**: AWS ALB Ingress Controller setup (commented)
- **NetworkPolicy**: Security policies (commented)
- **ConfigMap**: File mounting capabilities (commented)
- **Secrets**: AWS Secrets Manager integration (commented)

All advanced features are commented out by default - uncomment and configure as needed.

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test the chart
5. Submit a pull request

## License

This project is licensed under the MIT License.
