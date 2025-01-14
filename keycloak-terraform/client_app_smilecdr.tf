resource "keycloak_openid_client" "smile" {
  realm_id                     = data.keycloak_realm.realm.id
  client_id                    = var.smile-client.id
  name                         = "Smile CDR"
  description                  = "Smile Authorization/Resource Server"
  enabled                      = true
  standard_flow_enabled        = true
  service_accounts_enabled     = true
  implicit_flow_enabled        = false
  direct_access_grants_enabled = true
  access_type                  = "CONFIDENTIAL"
  login_theme                  = var.smile-client.login_theme
  valid_redirect_uris          = var.smile-client.valid_redirects
}

resource "keycloak_openid_client_default_scopes" "smile_default_scopes" {
  realm_id  = keycloak_openid_client.smile.realm_id
  client_id = keycloak_openid_client.smile.id

  default_scopes = [
    "profile",
    "web-origins",
  ]
}

resource "keycloak_openid_client_optional_scopes" "smile_optional_scopes" {
  realm_id  = keycloak_openid_client.smile.realm_id
  client_id = keycloak_openid_client.smile.id

  optional_scopes = [
    "address",
    "phone",
    "microprofile-jwt",
    "acr"
  ]
}

// ====== FROM MOH KEYCLOAK PC ROSTER ROLES. THIS IS HALF-BAKED AND RIDICULOUSLY MODELED... WTF.


resource "keycloak_generic_role_mapper" "client_smile_status_role_md_mapper" {
  realm_id  = keycloak_openid_client.smile.realm_id
  client_id = keycloak_openid_client.smile.id
  role_id   = keycloak_role.client_role_md.id
}

resource "keycloak_generic_role_mapper" "client_smile_status_role_rnp_mapper" {
  realm_id  = keycloak_openid_client.smile.realm_id
  client_id = keycloak_openid_client.smile.id
  role_id   = keycloak_role.client_role_rnp.id
}

resource "keycloak_generic_role_mapper" "client_smile_status_role_moa_mapper" {
  realm_id  = keycloak_openid_client.smile.realm_id
  client_id = keycloak_openid_client.smile.id
  role_id   = keycloak_role.client_role_moa.id
}

resource "keycloak_generic_role_mapper" "client_smile_status_role_practitioner_mapper" {
  realm_id  = keycloak_openid_client.smile.realm_id
  client_id = keycloak_openid_client.smile.id
  role_id   = keycloak_role.client_role_practitioner.id
}

resource "keycloak_openid_user_attribute_protocol_mapper" "client_smile_endorser_attribute_mapper" {
  realm_id            = keycloak_openid_client.smile.realm_id
  client_id           = keycloak_openid_client.smile.id
  name                = "endorser_data"
  user_attribute      = "endorser_data"
  claim_name          = "endorser_data"
  claim_value_type    = "String"
  multivalued         = true
  add_to_id_token     = true
  add_to_access_token = true
  add_to_userinfo     = true
}


resource "keycloak_openid_user_client_role_protocol_mapper" "user_smile_client_role_mapper" {
  realm_id                    = keycloak_openid_client.smile.realm_id
  client_id                   = keycloak_openid_client.smile.id
  name                        = "User LICENCE-Status Role"
  claim_name                  = "provider_role"
  client_id_for_role_mappings = "LICENCE-STATUS"
  client_role_prefix          = ""
  multivalued                 = true
}

// ----- PROTOTYPING USER ATTRIBUTE MAPPING 

resource "keycloak_openid_user_attribute_protocol_mapper" "smile_provider_identifier" {
  realm_id            = keycloak_openid_client.smile.realm_id
  client_id           = keycloak_openid_client.smile.id
  name                = "practitionerId"
  user_attribute      = "practitionerId"
  claim_name          = "practitionerId"
  claim_value_type    = "String"
  add_to_id_token     = true
  add_to_access_token = true
  add_to_userinfo     = true
}
resource "keycloak_openid_user_attribute_protocol_mapper" "smile_provider_status" {
  realm_id            = keycloak_openid_client.smile.realm_id
  client_id           = keycloak_openid_client.smile.id
  name                = "practitionerStatus"
  user_attribute      = "practitionerStatus"
  claim_name          = "practitionerStatus"
  claim_value_type    = "String"
  add_to_id_token     = true
  add_to_access_token = true
  add_to_userinfo     = true
}

resource "keycloak_openid_user_attribute_protocol_mapper" "smile_provider_role" {
  realm_id            = keycloak_openid_client.smile.realm_id
  client_id           = keycloak_openid_client.smile.id
  name                = "practitionerRole"
  user_attribute      = "practitionerRole"
  claim_name          = "practitionerRole"
  claim_value_type    = "String"
  add_to_id_token     = true
  add_to_access_token = true
  add_to_userinfo     = true
}

resource "keycloak_openid_user_attribute_protocol_mapper" "smile_provider_license" {
  realm_id            = keycloak_openid_client.smile.realm_id
  client_id           = keycloak_openid_client.smile.id
  name                = "practitionerLicense"
  user_attribute      = "practitionerLicense"
  claim_name          = "practitionerLicense"
  claim_value_type    = "String"
  add_to_id_token     = true
  add_to_access_token = true
  add_to_userinfo     = true
}

resource "keycloak_openid_user_attribute_protocol_mapper" "smile_provider_specialty" {
  realm_id            = keycloak_openid_client.smile.realm_id
  client_id           = keycloak_openid_client.smile.id
  name                = "practitionerSpecialty"
  user_attribute      = "practitionerSpecialty"
  claim_name          = "practitionerSpecialty"
  claim_value_type    = "String"
  add_to_id_token     = true
  add_to_access_token = true
  add_to_userinfo     = true
}



