variable "enabled" {
  type        = bool
  default     = true
  description = "Variable indicating whether deployment is enabled."
}

variable "helm_services" {
  default = [
    {
      name          = "argo-cd"
      release_name  = "argo-cd"
      chart_version = "3.26.12"
      settings      = {}
    },
    {
      name          = "argo-rollouts"
      release_name  = "argo-rollouts"
      chart_version = "2.5.0"
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
  description = "Kubernetes namespace to deploy Argo CD Helm chart."
}

variable "mod_dependency" {
  default     = null
  description = "Dependence variable binds all AWS resources allocated by this module, dependent modules reference this variable."
}

variable "settings" {
  default     = {}
  description = "Additional settings which will be passed to the Helm chart values."
}
