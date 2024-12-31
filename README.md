# MediSwift Kubernetes Deployment

This repository contains the deployment configuration and setup for the MediSwift application. MediSwift is a web application designed for managing medicines and healthcare products. It is deployed using Kubernetes on AWS EKS and uses AWS Route 53 for DNS configuration.

## Features
- **Frontend**: React application deployed via NGINX.
- **Backend**: Node.js API server connected to a MongoDB database.
- **Infrastructure**: Deployed using AWS Elastic Kubernetes Service (EKS).
- **Domain**: Configured with Route 53 to use `varsha-mediswift.com`.

---

## Table of Contents
1. [Pre-requisites](#pre-requisites)
2. [Infrastructure Setup](#infrastructure-setup)
3. [Application Deployment](#application-deployment)
4. [Verification Steps](#verification-steps)
5. [Debugging](#debugging)
6. [License](#license)

---

## Pre-requisites
1. **AWS Account** with EKS and Route 53 setup.
2. **Tools Installed**:
   - `aws-cli` (configured with your AWS credentials)
   - `kubectl`
   - `eksctl`
   - `docker`
3. **MongoDB Database**: Ensure MongoDB is configured and accessible.
4. **Domain Name**: Purchased and managed in Route 53 (`varsha-mediswift.com`).

---

## Infrastructure Setup

### 1. Create an EKS Cluster
Use `eksctl` to create the Kubernetes cluster:
```(bash)
eksctl create cluster --name mediapp-eks-cluster --region us-east-1 --nodes 2 --node-type t3.medium
```

### 2. Verifying an EKS Cluster
```(bash)
kubectl get nodes
```
<img width="981" alt="image" src="https://github.com/user-attachments/assets/62b9ffc8-5a47-4c42-a8b3-d10f169cdf59" />

### 3. Configure kubeconfig

```(bash)
aws eks --region us-east-1 update-kubeconfig --name mediapp-eks-cluster
```

<img width="1040" alt="image" src="https://github.com/user-attachments/assets/7d2e1092-8088-44b2-99c3-e6d181d4d797" />

## Application Deployment
### 1. Build and Push Docker Images: Build and push the Docker images to ECR (Elastic Container Registry):

#### Backend:
```(bash)
docker buildx build --platform linux/amd64,linux/arm64 -t 381491906666.dkr.ecr.us-east-1.amazonaws.com/medicine-backend:multiarch --push ./backend
```

### 2. Frontend:
```(bash)
docker buildx build --platform linux/amd64,linux/arm64 -t 381491906666.dkr.ecr.us-east-1.amazonaws.com/medicine-frontend:multiarch --push ./frontend
```

### 3. Apply Kubernetes Manifests: Deploy the backend and frontend using Kubernetes manifests:

```(bash)
kubectl apply -f backend/backend-deployment.yaml
```

```(bash)
kubectl apply -f backend/backend-service.yaml
```

```(bash)
kubectl apply -f frontend/frontend-deployment.yaml
```

```(bash)
kubectl apply -f frontend/frontend-service.yaml
```

### 4. Configure Route 53 for Domain

In the AWS Route 53 console, create an A record that points to the Load Balancer DNS of the frontend-service.
Verified that the domain (http://varsha-mediswift.com) is linked to my application.

### Verification Steps
#### 1. Check Pods and Services: Ensure all pods and services are running:

```(bash)
kubectl get pods
```

```(bash)
kubectl get services
```

#### 2. Test Frontend and Backend Connectivity: Access the frontend using the Load Balancer DNS or the configured domain:

```(bash)
curl http://varsha-mediswift.com
```

Test the backend API using:
```(bash)
curl http://backend-service.default.svc.cluster.local:5001/api/test
```

#### 3. Check Logs: Check the logs to ensure no errors:

Backend:

```(bash)
kubectl logs -l app=backend
```

Frontend:
```(bash)
kubectl logs -l app=frontend
```

## Debugging
#### Common Issues: DNS Propagation Delay:

1. DNS changes in Route 53 may take time to propagate. Use nslookup to verify:
```(bash)
nslookup varsha-mediswift.com
```

#### MongoDB Connection Errors:

2. Ensured the MongoDB URI is correctly set in the backend-env Kubernetes secret. Added the EKS cluster's CIDR ranges to MongoDB's IP whitelist.

#### Application Not Loading:

Check if the frontend is configured with the correct backend URL:
```(bash)
env:
  - name: REACT_APP_BACKEND_URL
    value: "http://backend-service.default.svc.cluster.local:5001/api"
```

Pods Stuck in CrashLoopBackOff: Check the logs:
```(bash)
kubectl logs <pod-name>
```
P.S. Get Pod names using ``` kubectl get pods ```

## Folder Structure
```
.
├── backend
│   ├── Dockerfile
│   ├── backend-deployment.yaml
│   ├── backend-service.yaml
│   └── src
├── frontend
│   ├── Dockerfile
│   ├── frontend-deployment.yaml
│   ├── frontend-service.yaml
│   └── src
└── README.md
```

#### Sample Backend Environment File (Later Stored as Kubernetes Secret)
```
.env
# /backend/.env
SEC_KEY=<your_secret_key>                       # Replace <your_secret_key> with the secure key used for your backend
JWT_SEC=<your_jwt_secret_key>                  # Replace <your_jwt_secret_key> with the secure JWT secret key
MONGODB_URI=mongodb+srv://<username>:<password>@<cluster-name>.mongodb.net/?retryWrites=true&w=majority&appName=<app-name>&connectTimeoutMS=30000&socketTimeoutMS=30000
# Replace <username>, <password>, <cluster-name>, and <app-name> with your MongoDB details
STRIPE_KEY=<your_stripe_key>                   # Replace <your_stripe_key> with your Stripe secret key
PORT=5001                                      # Backend application port
```

#### Sample Frontend Environment File (Later Stored as Kubernetes Secret)
```
.env
# /frontend/.env
REACT_APP_BACKEND_URL=http://<load-balancer-url>/api
# Replace <load-balancer-url> with your backend's Kubernetes LoadBalancer URL
```

## Go to [http://varsha-mediswift.com/](http://varsha-mediswift.com/)
