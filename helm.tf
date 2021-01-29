resource "helm_release" "argocd" {
  depends_on = [var.mod_dependency, kubernetes_namespace.argocd]
  count      = var.enabled ? length(var.helm_services) : 0
  name       = var.helm_services[count.index].name
  chart      = var.helm_services[count.index].release_name
  repository = var.helm_chart_repo
  version    = var.helm_services[count.index].chart_version
  namespace  = var.namespace

  set {
    name  = "installCRDs"
    value = false
  }

  dynamic "set" {
    for_each = var.helm_services[count.index].settings

    content {
      name  = set.key
      value = set.value
    }
  }

}