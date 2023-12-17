provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "default" {
  metadata {
# Update the namespace name with the use of below new namespace and new deployment will be created
    name = "ns-1"
  }
}

resource "kubernetes_deployment" "nginx" {
  metadata {
    name      = "nginx"
    namespace = kubernetes_namespace.default.metadata[0].name
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "nginx"
      }
    }

    template {
      metadata {
        labels = {
          app = "nginx"
        }
      }

      spec {
        container {
          image = "sumit05/nginx:${var.app_version}"
          name  = "nginx"
        }
      }
    }
  }
}
resource "kubernetes_service" "app_service" {
  metadata {
    name      = "nginx"
    namespace = kubernetes_namespace.default.metadata[0].name
  }

  spec {
    selector = {
      app = "nginx"
    }

    port {
      protocol = "TCP"
      port     = 80
      target_port = 80
    }

    type = "NodePort"
  }
}
