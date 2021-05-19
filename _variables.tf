variable "enabled" {
  type        = bool
  default     = true
  description = "Variable indicating whether deployment is enabled."
}

variable "helm_services" {
  # type = list(object({
  #   name          = string
  #   chart_version = string
  #   release_name  = string
  #   settings      = map(any)
  # }))
  default = [
    {
      name          = "argo-cd"
      release_name  = "argo-cd"
      chart_version = "3.2.3"
      settings      = {}
    },
    {
      name          = "argo-rollouts"
      release_name  = "argo-rollouts"
      chart_version = "0.5.2"
      settings      = {}
    }
  ]
}

variable "helm_chart_repo" {
  type        = string
  default     = "https://argoproj.github.io/argo-helm"
  description = "Argo CD repository name."
}

variable "create_namespace" {
  type        = bool
  default     = true
  description = "Whether to create Kubernetes namespace with name defined by `namespace`."
}

variable "namespace" {
  type        = string
  default     = "argocd"
  description = "Kubernetes namespace to deploy ACK Helm chart."
}

variable "mod_dependency" {
  default     = null
  description = "Dependence variable binds all AWS resources allocated by this module, dependent modules reference this variable."
}