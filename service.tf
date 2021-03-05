
resource "azurerm_resource_group" "rgdev" {
  name     = local.service-rg-dev
  location = "East US"
}

resource "azurerm_resource_group" "rgprd" {
  name     = local.service-rg-prd
  location = "East US"
}

resource "azurerm_app_service_plan" "plandev" {
  name                = "gestion${local.service-dev-enviroment}plan"
  location            = "East US"
  resource_group_name = "${azurerm_resource_group.rgdev.name}"

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service_plan" "planprd" {
  name                = "gestion${local.service-prd-enviroment}plan"
  location            = "East US"
  resource_group_name = "${azurerm_resource_group.rgprd.name}"

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "web_dev" {
  name                = "asdx12gestion${local.service-dev-enviroment}web"
  location            = "East US"
  resource_group_name = "${azurerm_resource_group.rgdev.name}"
  app_service_plan_id = "${azurerm_app_service_plan.plandev.id}"
}

resource "azurerm_app_service" "web_prd" {
  name                = "asdx12gestion${local.service-prd-enviroment}web"
  location            = "East US"
  resource_group_name = "${azurerm_resource_group.rgprd.name}"
  app_service_plan_id = "${azurerm_app_service_plan.planprd.id}"
}

resource "azurerm_virtual_network" "dev" {
  name                = "devvnet"
  address_space       = ["10.0.0.0/16"]
  location            = "East US"
  resource_group_name = "${azurerm_resource_group.rgdev.name}"
}

resource "azurerm_subnet" "dev" {
  name                 = "AzureFirewallDevSubnet"
  resource_group_name  = "${azurerm_resource_group.rgdev.name}"
  virtual_network_name = azurerm_virtual_network.dev.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_virtual_network" "prd" {
  name                = "prdvnet"
  address_space       = ["10.0.0.0/16"]
  location            = "East US"
  resource_group_name = "${azurerm_resource_group.rgprd.name}"
}

resource "azurerm_subnet" "prd" {
  name                 = "AzureFirewallPrdSubnet"
  resource_group_name  = "${azurerm_resource_group.rgprd.name}"
  virtual_network_name = azurerm_virtual_network.prd.name
  address_prefixes     = ["10.0.1.0/24"]
}