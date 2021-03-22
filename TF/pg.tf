resource "helm_release" "database" {
  name       = "database"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"
  namespace  = kubernetes_namespace.todo-ns.metadata.0.name
  
  set {
    name  = "postgresqlDatabase"
    value = var.pg_dbname
  }
  # set {
  #   name  = "postgresqlUsername"
  #   value = var.pg_user
  # }

  set {
    name  = "postgresqlPassword"
    value = var.pg_password
  }

}