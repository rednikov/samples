The project was developed specifically to show a possible way to quickly deploy a Django application inside a kubernetes cluster. For this purpose, a three-level architecture was used, including frontend, application, and database. This repository contains the sample application, all the necessary configuration files and templates.

Components and tools used in the project:
 - minicube
 - kubectl 
 - helm
 - terraform
 - sample app (https://github.com/shacker/django-todo.git)
 - Django site (https://github.com/shacker/gtd.git)

To start, the application is placed inside the docker image, then the image is run inside the Kubernetes caster using Terraform.

To deploy the app in the new env please follow the instructions:

### 1. Start and configure kubernates
 - minikube start --vm-driver=docker   -   spin up default kubernates cluster
 - minikube addons enable ingress  -   enable nginx ingress controller

### 2. Develop application and build image inside minikube env
 - eval $(minikube docker-env)
 - cd todo/app sub-directory
 - docker build -t todo_web .

### 3. Deploy application and related components into minikube cluster
 - cd todo/TF directory
 - (optional) adjust tfvars file with your wishes
 - terraform init
 - terraform apply -auto-approve

check Terraform output and open provided IP. ex: "load_balancer_ip = "192.168.49.2""
