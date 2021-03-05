locals {
    #Debe ser único, ejemplo, alias = "jyapur"
    company = "Contoso1"
    alias = ""
    #ejemplo, region = "East US 2"
    region = "East US"
    #az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<subscriptionID>/resourceGroups/<resourceGroupName>"
    #areas
    bussiness-unit-1 = "Cumplimiento"
    bussiness-unit-2 = "Compras"
    bussiness-unit-3 = "UsuariosDeNegocio"
    bussiness-unit-4 = "Proveedores"

    bussiness-unit-1-short = "CUPL"
    bussiness-unit-2-short = "COMP"
    bussiness-unit-3-short = "USRN"
    bussiness-unit-4-short = "PROV"
    #ambientes
    development = "Desarrollo"
    production = "Production"
}

