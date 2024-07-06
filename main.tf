terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
  #backend "azurerm" {
  #    resource_group_name  = "tfstate"
  #    storage_account_name = "firststate"
  #    container_name       = "tfstate"
  #    key                  = "terraform.tfstate"
  #}

}

provider "azurerm" {
  features {}
}



#resource "azurerm_resource_group" "test_rg1" {
#  name     = "my-resource-group"
#  location = "Central US"
#}

resource "azurerm_resource_group" "tfstate" {
  name     = "tfstate"
  location = "Central US"
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "firststate"
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_nested_items_to_be_public = false

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}
