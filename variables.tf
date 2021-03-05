variable "mandatory_tag_keys" {
  type        = list
  description = "List of mandatory tag keys used by policies 'addTagToRG','inheritTagFromRG','bulkAddTagsToRG','bulkInheritTagsFromRG'"
  default = [
    "Ambiente",
    "Area",
    "Empresa"
  ]
}


variable "bussiness_units" {
  type        = list
  description = "List of Business units for company"
  default = [
    "Cumplimiento",
    "Compras",
    "UsuariosDeNegocio",
    "Proveedores"
  ]
}


variable "bussiness_units_short" {
  type        = list
  description = "List of Business units short for company"
  default = [
    "cupl",
    "comp",
    "usrn",
    "prov"
  ]
}

variable "bussiness_units_short" {
  type        = list
  description = "List of Business units short for company"
  default = [
    "cupl",
    "comp",
    "usrn",
    "prov"
  ]
}

