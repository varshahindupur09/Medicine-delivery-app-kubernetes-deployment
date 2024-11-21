# Medicine-delivery-app-kubernetes-deployment
I'm using this repository for deploying the medicine delivery app on Kubernetes.

# commands
docker build -t medicine-backend:1.0 .
docker run -p 5001:5001 --env-file ./backend/.env medicine-backend:1.0

docker build -t medicine-frontend:1.0 .
docker run -p 3000:80 medicine-frontend:1.0