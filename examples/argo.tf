module "argocd" {
  source = "git::https://github.com/DNXLabs/terraform-aws-eks-argocd.git?ref=0.2.0"

  enabled = true

  helm_services = [
    {
      name          = "argo-cd"
      release_name  = "argo-cd"
      chart_version = "3.3.5"
      settings      = {
        "server" = {
          "service" = {
            "type" = "NodePort"
          }
          "ingress" = {
            "enabled" = true
            "https" = true
            "paths" = ["/*"]
            "annotations" = {
              "ingress.kubernetes.io/group.name" = "dev-apps-private"
              "kubernetes.io/ingress.class" = "alb"
              "alb.ingress.kubernetes.io/certificate-arn" = "arn:aws:acm:us-east-1:000:certificate/000"
              "alb.ingress.kubernetes.io/scheme" = "internal"
              "alb.ingress.kubernetes.io/listen-ports" = "[{\"HTTP\": 80}, {\"HTTPS\":443}]"
              "alb.ingress.kubernetes.io/actions.ssl-redirect" = "{\"Type\": \"redirect\", \"RedirectConfig\": { \"Protocol\": \"HTTPS\", \"Port\": \"443\", \"StatusCode\": \"HTTP_301\"}}"
              "alb.ingress.kubernetes.io/target-type" = "instance"
              "alb.ingress.kubernetes.io/success-codes" = "200"
              "alb.ingress.kubernetes.io/group.order" = "51"
              "alb.ingress.kubernetes.io/healthcheck-protocol" = "HTTPS"
              "alb.ingress.kubernetes.io/backend-protocol" = "HTTPS"
            }
            "hosts" = ["argocd.dev.private.mydomain.com"]
          }
        }
      }
    },
    {
      name          = "argo-rollouts"
      release_name  = "argo-rollouts"
      chart_version = "0.5.2"
      settings      = {}
    }
  ]
}