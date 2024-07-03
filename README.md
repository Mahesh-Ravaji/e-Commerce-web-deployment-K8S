
### <h1>Kubernetes Setup </h1> ###


To use Kubernetes (K8s) with your Node.js application that you've Dockerized, you'll follow these general steps:

### 1. Kubernetes Configuration

#### Create Kubernetes Manifests

Create Kubernetes manifests in YAML format that describe your application's deployment, service, and optionally an Ingress (if you want to expose your application externally).

Here's a basic example:

**deployment.yaml** - Defines how your application should be deployed:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-node-app
spec:
  replicas: 1
  selector:
    matchLabels:
      app: my-node-app
  template:
    metadata:
      labels:
        app: my-node-app
    spec:
      containers:
        - name: my-node-app
          image: your-docker-registry/your-node-app-image:tag
          ports:
            - containerPort: 8000
```

Replace `your-docker-registry/your-node-app-image:tag` with the actual path to your Docker image (e.g., `myregistry/my-node-app:latest`).

**service.yaml** - Defines how clients can access your application:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-node-app
spec:
  selector:
    app: my-node-app
  ports:
    - protocol: TCP
      port: 8000
      targetPort: 8000
  type: ClusterIP
```

This `Service` will create an internal IP address that other Kubernetes pods can use to access your application.

#### Optional: Ingress Configuration

If you want to expose your application to the outside world, you can use an Ingress resource. Here's a basic example:

**ingress.yaml** - Defines how external traffic will reach your application:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-node-app-ingress
spec:
  rules:
    - host: your.domain.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: my-node-app
                port:
                  number: 8000
```

Replace `your.domain.com` with your actual domain name.

### 2. Deploying to Kubernetes

Once you have your Kubernetes manifests ready:

1. **Apply Manifests**: Use `kubectl apply` to deploy your application to Kubernetes:

   ```bash
   kubectl apply -f deployment.yaml
   kubectl apply -f service.yaml
   kubectl apply -f ingress.yaml  # If using Ingress
   ```

2. **Verify Deployment**: Check the deployment status:

   ```bash
   kubectl get deployments
   ```

   Ensure that the deployment has `1/1` replicas available.

3. **Verify Service**: Check the service and get its ClusterIP:

   ```bash
   kubectl get services
   ```

   Verify that your service is running and note its ClusterIP.

4. **Verify Ingress (Optional)**: If you used Ingress, verify that the Ingress resource is created and note the external IP.

### 3. Accessing Your Application

- **Internal Access**: If you only need internal access within the Kubernetes cluster, use the ClusterIP of your service to access your application from other pods.

- **External Access**: If you used an Ingress resource, you can access your application using the configured host (`your.domain.com` in the example) via the external IP provided by your cloud provider.

### 4. Managing and Scaling

- **Scaling**: You can scale your application by adjusting the `replicas` field in your deployment.yaml file and reapplying it using `kubectl apply -f deployment.yaml`.

- **Updating**: To update your application, build a new Docker image with your changes, push it to your Docker registry, update the image tag in your deployment.yaml file, and apply the changes with `kubectl apply -f deployment.yaml`.

### Additional Resources

- Kubernetes provides many more features like PersistentVolumes, Secrets, ConfigMaps, and more. Explore the Kubernetes documentation and tutorials to further enhance and secure your application.

By following these steps, you can effectively deploy and manage your Dockerized Node.js application using Kubernetes (K8s). If you have specific questions or need further clarification on any part of this process, feel free to ask!


Visualization:

┌─────────────────────────┐
│      Deployment         │
│   (mypage-deployment)   │
│                         │
│   ┌───────────────────┐ │
│   │   Selector         │ │
│   │   (matchLabels)    │ │
│   │   app: mypage      │ │
│   └───────────────────┘ │
│                         │
│   ┌───────────────────┐ │
│   │    Pod Template    │ │
│   │    (template)      │ │
│   │   ┌───────────────┐ │
│   │   │   Labels      │ │
│   │   │   app: mypage │ │
│   │   └───────────────┘ │
│   │   ┌───────────────┐ │
│   │   │   Containers  │ │
│   │   │   ┌───────────┐ │
│   │   │   │   Name    │ │
│   │   │   │mypage-container│ │
│   │   │   │   Image   │ │
│   │   │   │mylandingpageweb:latest│ │
│   │   │   │   Ports   │ │
│   │   │   │  ┌───────┐│ │
│   │   │   │  │ 8000  ││ │
│   │   │   │  └───────┘│ │
│   │   │   └───────────┘ │
│   │   └───────────────┘ │
│   └───────────────────┘ │
└─────────────────────────┘
