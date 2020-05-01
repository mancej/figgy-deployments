## Please fill out this file to custom-configure your figgy deployment to meet your needs

## IMPORTANT:
## If you have already provisioned figgy, rearranging values under `encryption_keys` or `user_types` could require
## these resources to be removed/recreated which would probably be a pretty bad thing~!

locals {
  # If you __DO NOT_ want figgy to create its own S3 bucket, set this to true, then specify the `var.deploy_bucket`
  # with the appropriate deployment bucket name variable.
  custom_bucket = false

  # How many unique roles will figgy users need? Each of these types should map to a particular figgy user story.
  role_types = ["devops", "data", "dba", "sre", "dev"]

  # Encryption keys to allow certain roles to use to encrypt and decrypt secrets stored with figgy. You will map access below
  encryption_keys = ["devops", "data", "dba", "app"]

  # List of namespaces at the root level of your parameter stoer namespace. Figgy (and its users)
  # will ONLY have access to configs under these namespaces.
  # ** /shared is required by figgy, all otheres are optional
  root_namespaces = ["/shared", "/app", "/data", "/devops", "/sre", "/dba"]

  # Configure access permissions by mapping your role_types to namespace access levels. Be careful to ensure you
  # don't have any typos here. These must match items role_types and root_namespace configurations
  # Format: Map[str:List[str]], or more specifically Map[encryption_key:List[namespace]]
  role_to_ns_access = {
    "devops" = ["/app", "/devops", "/data", "/sre"],
    "data" = ["/app", "/data"],
    "sre" = ["/sre", "/app", "/data"],
    "dev" = ["/app"],
    "dba" = ["/dba"]
  }

  # Map role type access to various encryption keys provisioned by figgy.
  role_to_kms_access = {
    "devops" = [ "devops", "app", "data" ]
    "data" = [ "data", "app" ]
    "dba" = [ "dba", "app" ]
    "sre" = [ "app" ]
    "dev" = [ "app"]
  }

  # Enable sso true/false
  enable_sso = true

  # SSO Type: Options are okta/google
  sso_type = "okta"
}