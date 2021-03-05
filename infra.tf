provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  features {}
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

#Public Sub net
resource "azurerm_network_security_group" "secgrouppubprod" {
  name                = "${local.bussiness-unit-1-short}pub${local.production-short}SecutiryGroup"#  "acceptanceTestSecurityGroup1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_network_ddos_protection_plan" "ddospubprod" {
  name                = "${local.bussiness-unit-1-short}pub${local.production-short}Ddos"
  location            = azurerm_resource_group.rgcompanycomplianceprod.location
  resource_group_name = azurerm_resource_group.rgcompanycomplianceprod.name
}

resource "azurerm_virtual_network" "vnprod" {
  name                = "${local.bussiness-unit-1-short}${local.production-short}virtualNetwork"
  location            = azurerm_resource_group.rgcompanycomplianceprod.location
  resource_group_name = azurerm_resource_group.rgcompanycomplianceprod.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  ddos_protection_plan {
    id     = azurerm_network_ddos_protection_plan.ddospubprod.id
    enable = true
  }

  subnet {
    name           = "publicsubnet"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "privatesubnet1"
    address_prefix = "10.0.2.0/24"
  }

  subnet {
    name           = "privatesubnet2"
    address_prefix = "10.0.3.0/24"
    security_group = azurerm_network_security_group.secgrouppubprod.id
  }

  tags = {
    Ambiente = "${local.production}"
    Area = "${local.bussiness-unit-1}"
    Empresa = "${local.company}"
  }
}


##################### Development ################################

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




