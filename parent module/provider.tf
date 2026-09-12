terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.81.0"
    }
  }

  #  backend "azurerm" {
  #   resource_group_name = "saurabh-rg"
  #   storage_account_name = "saurabhstorage"
  #   container_name = "baba-container"
  #   key = "baba.tfstate"
  # }
}

provider "azurerm" {
  features {}
  subscription_id = "6beaa619-f65e-4ecb-8c10-630f149215a9"
}





