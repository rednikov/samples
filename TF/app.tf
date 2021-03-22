resource "helm_release" "todo" {
  depends_on = [ helm_release.database ]
  name       = "todo"
  namespace  = var.namespace
  chart      = "files/helm-todo"
  timeout = "300"

  set {
    name  = "autoscaling.enabled"
    value = "true"
  }
  set {
    name  = "autoscaling.minReplicas"
    value = var.app_minReplicas
  }
  set {
    name  = "autoscaling.maxReplicas"
    value = var.app_maxReplicas
  }
  set {
    name  = "image.repository"
    value = "todo_web"
  }
  set {
    name  = "image.tag"
    value = "latest"
  }
  set {
    name  = "image.pullPolicy"
    value = "IfNotPresent" # IfNotPresent or Always for debugging
  }
  set {
    name  = "service.port"
    value = var.app_port
  }
  set {
    name  = "env.dbport"
    value = "5432"
  }
  set {
    name  = "env.dbhost"
    value = "database-postgresql.${kubernetes_namespace.todo-ns.metadata.0.name}.svc.cluster.local"
  }
  set {
    name  = "env.dbname"
    value = var.pg_dbname 
  }
  set {
    name  = "env.dbuser"
    value = var.pg_user
  }
  set {
    name  = "env.dbpass"
    value = var.pg_password
  }
}