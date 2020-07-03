# THIS IS OPTIONAL. Only configure this if you are using bastion-account-based authentication and _not_ SSO authentication.

locals {
  # MFA Enabled - "true/false" - Require MFA for authentication for bastion based auth? For SSO users MFA
  # is managed by your SSO provider. This is only for `bastion` MFA enforcement.
  # The CLI supports MFA for SSO / Bastion auth types.
  mfa_enabled = true

  # Please provide a mapping from all AWS "environments" to their respective account Ids
  # Format: "env" -> "account_id"
  associated_accounts = tomap({
    "dev" : "123467891011",
    "qa" :  "123467891011",
    "stage": "123467891011",
    "prod" : "123467891011",
    "bastion" : "123467891011"
  })

  # Here, do a mapping of each user and their specified role(s)
  # These will be dynamically provisioned and configured for cross-account role authorizations
  bastion_users = tomap({
    "jordan.devops": ["devops", "dev", "dba", "sre", "data"]
    "jordan.dba": ["dba"]
    "jordan.sre": ["sre"]
    "jordan.data": ["dba", "data"]
    "jordan.dev": ["dev"]
  })
}


