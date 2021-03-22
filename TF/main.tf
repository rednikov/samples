
resource "kubernetes_namespace" "todo-ns" {
  metadata {
    name = var.namespace
  }
}