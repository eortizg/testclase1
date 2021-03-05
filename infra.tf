provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  features {}
}

#Compliance Landing Zone For company, Development 
resource "azurerm_resource_group" "rgcompanycompliancedev" {
  name     = "RG${local.bussiness-unit-1-short}${local.development-short}"
  location = "East US"
  tags = {
    Ambiente = "${local.development}"
    Area = "${local.bussiness-unit-1}"
    Empresa = "${local.company}"
  }
}
resource "azurerm_storage_account" "stgcompliancedev" {
  name                     = "stac${local.bussiness-unit-1-short}${local.development-short}"
  resource_group_name      = "${azurerm_resource_group.rgcompanycompliancedev.name}"
  location                 = "${azurerm_resource_group.rgcompanycompliancedev.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Ambiente = "${local.development}"
    Area = "${local.bussiness-unit-1}"
    Empresa = "${local.company}"
  }
}


#Compliance Landing Zone For company, Production 
resource "azurerm_resource_group" "rgcompanycomplianceprod" {
  name     = "RG${local.bussiness-unit-1-short}${local.production-short}"
  location = "East US"
  tags = {
    Ambiente = "${local.production}"
    Area = "${local.bussiness-unit-1}"
    Empresa = "${local.company}"
  }
}

resource "azurerm_storage_account" "stgcomplianceprod" {
  name                     = "stac${local.bussiness-unit-1-short}${local.production-short}"
  resource_group_name      = "${azurerm_resource_group.rgcompanycomplianceprod.name}"
  location                 = "${azurerm_resource_group.rgcompanycomplianceprod.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Ambiente = "${local.production}"
    Area = "${local.bussiness-unit-1}"
    Empresa = "${local.company}"
  }
}