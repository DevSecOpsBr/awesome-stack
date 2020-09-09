ui = true
disable_mlock = true
disable_cache = true
log_level       = "debug"

listener "tcp" {
  address         = "vault_server:8200"
  cluster_address = "vault_server:8201"
  tls_disable     = "true"
}

storage "consul" {
  address       = "vault_consul_client:8500"
  token         = "01f47f9e-f989-966b-9acc-f88fde2e7f9f"
  path          = "vault/"
  scheme        = "http"
  service       = "vault"
  check_timeout = "60s"
}

# HA settings
cluster_addr    = "http://vault_server:8201"
api_addr        = "http://vault_server:8200"
