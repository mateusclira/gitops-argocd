terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.46.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "platform-${var.cname}"
  location = var.region
}

resource "azurerm_kubernetes_cluster" "main" {
  name                = "k8s-${var.cname}"
  location            = var.region
  resource_group_name = "platform-${var.cname}"
  dns_prefix          = "k8s-${var.cname}"

  default_node_pool {
    name       = "default"
    node_count = "2"
    vm_size    = "Standard_B2s"
  }
  identity {
    type = "SystemAssigned"
  }
  depends_on = [ azurerm_resource_group.main ]
}
