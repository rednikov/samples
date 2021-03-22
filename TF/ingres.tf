########################
# resource "helm_release" "nginx" {
#   name       = "nginx"

#   repository = "https://helm.nginx.com/stable"
#   chart      = "nginx-ingress"
#   namespace  = kubernetes_namespace.todo-ns.metadata.0.name
#   set {
#     name  = "controller.replicaCount"
#     value = 2
#   }
# }
########################

data "kubernetes_service" "todo-service" {
  metadata {
    namespace = kubernetes_namespace.todo-ns.metadata.0.name
    name      = "todo-helm-todo"
  }
}

resource "kubernetes_ingress" "todo-ingres" {
  depends_on = [ helm_release.todo ]
  wait_for_load_balancer = true
  metadata {
    namespace = kubernetes_namespace.todo-ns.metadata.0.name
    name = "minikube-todo-ingress"
    annotations = {
      "nginx.ingress.kubernetes.io/rewrite-target" = "/"
    }
  }
  spec {
    rule {
      http {
        path {
          path = "/"
          backend {
            service_name = data.kubernetes_service.todo-service.metadata.0.name
            # service_name = "todo-helm-todo"
            service_port = var.app_port
          }
        }
      }
    }
  }
}

# output "debug" {
#   value = data.kubernetes_service.todo-service.metadata.0.name
# }

# Display load balancer hostname (typically present in AWS)
output "load_balancer_hostname" {
  value = kubernetes_ingress.todo-ingres.status.0.load_balancer.0.ingress.0.hostname
}

# Display load balancer IP (typically present in GCP, or using Nginx ingress controller)
output "load_balancer_ip" {
  value = kubernetes_ingress.todo-ingres.status.0.load_balancer.0.ingress.0.ip
}