#!/bin/sh

# Apply namespace first if it doesn't exist
kubectl apply -f k8s/namespace.yaml

# Apply Kubernetes manifests
kubectl apply -f k8s/deployment.yaml -n dev-namespace
kubectl apply -f k8s/service.yaml -n dev-namespace
