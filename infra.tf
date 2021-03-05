provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  features {}
}

#Compliance Landing Zone For company, Production 
resource "azurerm_resource_group" "rgcompanybuprod" {
  count = length(var.bussiness_units)
  name     = "RG${var.bussiness_units_short[count.index]}${local.production-short}"
  location = "East US"
  tags = {
    Ambiente = "${local.production}"
    Area = "${var.bussiness_units[count.index]}"
    Empresa = "${local.company}"
  }
}
