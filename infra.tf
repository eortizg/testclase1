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

#Definiendo las redes
#Public Sub net
resource "azurerm_network_security_group" "secgrouppubprod" {
  count = "${length(var.bussiness_units_short)}"
  name                = "${var.bussiness_units_short[count.index]}pub${local.production-short}SecutiryGroup"#  "acceptanceTestSecurityGroup1"
  location            = azurerm_resource_group.rgcompanybuprod[count.index].location
  resource_group_name = azurerm_resource_group.rgcompanybuprod[count.index].name

  tags = {
    Ambiente = "${local.production}"
    Area = "${var.bussiness_units[count.index]}"
    Empresa = "${local.company}"
  }
}

resource "azurerm_virtual_network" "vnprod" {
  count = "${length(var.bussiness_units_short)}"
  name                = "${var.bussiness_units_short[count.index]}${local.production-short}virtualNetwork"
  location            = azurerm_resource_group.rgcompanybuprod[count.index].location
  resource_group_name = azurerm_resource_group.rgcompanybuprod[count.index].name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "publicsubnet"
    address_prefix = "10.0.1.0/24"
    security_group = azurerm_network_security_group.secgrouppubprod[count.index].id
  }

  subnet {
    name           = "privatesubnet1"
    address_prefix = "10.0.2.0/24"
  }

  subnet {
    name           = "privatesubnet2"
    address_prefix = "10.0.3.0/24"
  }

  tags = {
    Ambiente = "${local.production}"
    Area = "${local.bussiness-unit-1}"
    Empresa = "${local.company}"
  }
}

