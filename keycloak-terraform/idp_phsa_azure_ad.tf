resource "keycloak_oidc_identity_provider" "phsa_azure_ad" {
  realm              = data.keycloak_realm.realm.id
  alias              = var.keycloak_idp_phsa_azure_ad.alias
  display_name       = "PHSA Azure AD"
  enabled            = false
  store_token        = false
  trust_email        = true
  hide_on_login_page = false
  sync_mode          = "FORCE"
  authorization_url  = "${var.keycloak_idp_phsa_azure_ad.base_url}${var.keycloak_idp_phsa_azure_ad.auth_path}"
  token_url          = "${var.keycloak_idp_phsa_azure_ad.base_url}${var.keycloak_idp_phsa_azure_ad.token_path}"
  user_info_url  = "${var.keycloak_idp_phsa_azure_ad.base_url}${var.keycloak_idp_phsa_azure_ad.userinfo_path}"
  backchannel_supported = false
  client_id             = var.keycloak_idp_phsa_azure_ad.client_id
  client_secret         = var.keycloak_idp_phsa_azure_ad.client_secret
  default_scopes        = "openid profile email"
  validate_signature    = true
  jwks_url              = "${var.keycloak_idp_phsa_azure_ad.base_url}${var.keycloak_idp_phsa_azure_ad.jwks_path}"
  extra_config = {
    "clientAuthMethod" = "client_secret_post"
    "prompt"           = "login"
  }
}
