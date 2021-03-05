provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  features {}
}
resource "azurerm_resource_group" "rgcompanycompliancedev" {
  name     = "RG${local.bussiness-unit-1-short}${local.development}"
  location = "East US"
  tags = {
    Ambiente = "${local.development}"
    Area = "${local.bussiness-unit-1}"
    Empresa = "${local.company}"
  }
}
resource "azurerm_storage_account" "stgcompliancedev" {
  name                     = "STAC${local.bussiness-unit-1-short}${local.development}"
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