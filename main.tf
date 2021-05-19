terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.26"
    }
  }

  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}

}


resource "azurerm_resource_group" "tf_test" {
    name = "tfmainrg"
    location = "West Europe"
}

resource "azurerm_container_group" "tfcg_test" {
    name                    = "weatherapi"
    location                = azurerm_resource_group.tf_test.location
    resource_group_name     = azurerm_resource_group.tf_test.name

    ip_address_type     = "public"
    dns_name_label      = "mmterraformwa"
    os_type             = "Linux"

    container {
        name   = "mmweatherapi"
        image  = "michal1978/weatherapi"
        cpu    = "1"
        memory = "1"
        ports {
            port        = 80
            protocol    = "TCP"
        }
  }
    
}