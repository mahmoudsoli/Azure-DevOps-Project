# Feedback App (3-Tier Kubernetes Project)

A fully containerized and Kubernetes-ready feedback application consisting of:

- 🖼️ **Frontend**: Static HTML, CSS, JavaScript served with NGINX  
- 🧠 **Backend**: Python Flask REST API  
- 🛢️ **Database**: PostgreSQL 13

This project is perfect for DevOps demos, Kubernetes practice, and CI/CD hands-on learning.

---

## 🔧 Architecture

```
User Browser
    ↓
[ Frontend Service (NGINX) - Port 80 ]
    ↓ /api/*
[ Backend Service (Flask) - Port 5000 ]
    ↓
[ PostgreSQL Service - Port 5432 ]
```

---

## ⚙️ Tech Stack

| Layer     | Technology             |
|-----------|------------------------|
| Frontend  | HTML/CSS/JS, NGINX     |
| Backend   | Python 3.9, Flask      |
| Database  | PostgreSQL 13          |
| Containers| Docker                 |
| Orchestration | Kubernetes         |
| Local Dev | Docker Desktop + K8s   |

---

## 📝 Features

- Submit feedback messages via frontend  
- Retrieve and list feedback from PostgreSQL  
- Delete messages via UI 

---

## 🚀 Build & Push Docker Images

> Replace `<your-dockerhub-username>` with your actual Docker Hub account.

### 🔧 Backend
```bash
cd src/feedback_backend
docker build -t <your-dockerhub-username>/feedback-backend:latest .
docker push <your-dockerhub-username>/feedback-backend:latest
```

### 🎨 Frontend
```bash
cd src/feedback_frontend
docker build -t <your-dockerhub-username>/feedback-frontend:latest .
docker push <your-dockerhub-username>/feedback-frontend:latest
```

---

## ☸️ Kubernetes Deployment (Docker Desktop K8s)

### 1️⃣ Create DB Secret and ConfigMap (if not already created)
```bash
kubectl apply -f k8s/db-secret.yaml
kubectl apply -f k8s/postgres-init-configmap.yaml
```

### 2️⃣ Apply All Kubernetes Resources
```bash
kubectl apply -f k8s/
```

> This deploys:
> - Frontend Deployment + Service  
> - Backend Deployment + Service  
> - PostgreSQL Deployment + Service   
> - Secrets and ConfigMap

---

## 🌐 Access the Application

### 💻 Frontend UI
```bash
kubectl port-forward svc/frontend-service 8081:80
```
➡️ Open in browser: [http://localhost:8081](http://localhost:8081)

---

## 📂 Project Structure

```
.
├── README.md
├── azure-pipelines.yml
├── k8s/
│   ├── backend-deployment.yaml
│   ├── db-secret.yaml
│   ├── frontend-deployment.yaml
│   ├── postgres-deployment.yaml
│   └── postgres-init-configmap.yaml
│
├── requirements.txt
├── src/
│   ├── feedback_backend/
│   │   ├── app.py
│   │   ├── __init__.py
│   │   └── Dockerfile
│   ├── feedback_frontend/
│   │   ├── index.html
│   │   ├── nginx.conf
│   │   └── Dockerfile
│   └── feedback_db/
│       └── init.sql
│
└── tests/
    ├── __pycache__/
    └── test_app.py
```
