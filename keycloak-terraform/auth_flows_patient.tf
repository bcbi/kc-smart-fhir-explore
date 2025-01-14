resource "keycloak_authentication_flow" "first_bcsc_login_flow" {
  realm_id = data.keycloak_realm.realm.id
  alias    = "First BCSC Login"
}

resource "keycloak_authentication_execution" "first_bcsc_execution1" {
  realm_id          = data.keycloak_realm.realm.id
  parent_flow_alias = keycloak_authentication_flow.first_bcsc_login_flow.alias
  authenticator     = "idp-create-user-if-unique"
  requirement       = "ALTERNATIVE"

}

resource "keycloak_authentication_execution" "first_bcsc_execution2" {
  realm_id          = data.keycloak_realm.realm.id
  parent_flow_alias = keycloak_authentication_flow.first_bcsc_login_flow.alias
  authenticator     = "idp-auto-link"
  requirement       = "ALTERNATIVE"

  depends_on = [
    keycloak_authentication_execution.first_bcsc_execution1
  ]
}

resource "keycloak_authentication_flow" "patient_login_flow" {
  realm_id = data.keycloak_realm.realm.id
  alias    = "BCSC Patient Login"
}

resource "keycloak_authentication_execution" "bcsc_idp_redirector_execution" {
  realm_id          = data.keycloak_realm.realm.id
  parent_flow_alias = keycloak_authentication_flow.patient_login_flow.alias
  authenticator     = "identity-provider-redirector"
  requirement       = "REQUIRED"
}

resource "keycloak_authentication_execution_config" "bcsc_idp_redirector_execution_config" {
  realm_id     = data.keycloak_realm.realm.id
  execution_id = keycloak_authentication_execution.bcsc_idp_redirector_execution.id
  alias        = "bcsc-idp-redirector-config"
  config = {
    defaultProvider = "bcsc"
  }
}
resource "keycloak_authentication_execution" "patient_login_execution1" {
  realm_id          = data.keycloak_realm.realm.id
  parent_flow_alias = keycloak_authentication_flow.patient_login_flow.alias
  authenticator     = "idp-create-user-if-unique"
  requirement       = "ALTERNATIVE"

  depends_on = [
    keycloak_authentication_execution.bcsc_idp_redirector_execution
  ]
}

resource "keycloak_authentication_execution" "patient_login_execution2" {
  realm_id          = data.keycloak_realm.realm.id
  parent_flow_alias = keycloak_authentication_flow.patient_login_flow.alias
  authenticator     = "idp-auto-link"
  requirement       = "ALTERNATIVE"

  depends_on = [
    keycloak_authentication_execution.patient_login_execution1
  ]
}
