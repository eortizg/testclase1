provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  features {}
}

#Compliance Landing Zone For company, Production 
resource "azurerm_resource_group" "rgcompanybuprod" {
  count = "${length(var.bussiness_units_short)}"
  name     = "RG${var.bussiness_units_short[count.index]}${local.production-short}"
  location = "East US"
  tags = {
    Ambiente = "${local.production}"
    Area = "${var.bussiness_units[count.index]}"
    Empresa = "${local.company}"
  }
}

resource "azurerm_storage_account" "stgprod" {
  count = "${length(var.bussiness_units_short)}"
  name                     = "stac${var.bussiness_units_short[count.index]}${local.production-short}"
  resource_group_name      = "${azurerm_resource_group.rgcompanybuprod[count.index].name}"
  location                 = "${azurerm_resource_group.rgcompanybuprod[count.index].location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Ambiente = "${local.production}"
    Area = "${var.bussiness_units[count.index]}"
    Empresa = "${local.company}"
  }
}