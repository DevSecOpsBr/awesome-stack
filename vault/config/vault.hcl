# Settings for vault server

ui = true
disable_mlock = true
disable_cache = true
log_level       = "debug"

listener "tcp" {
  address         = "0.0.0.0:8200"
  cluster_address = "0.0.0.0:8201"
  tls_disable     = "true"
}

storage "consul" {
  address       = "consul_servers:8500"
  token         = "01f47f9e-f989-966b-9acc-f88fde2e7f9f"
  path          = "vault/"
  scheme        = "http"
  service       = "vault"
  check_timeout = "60s"
}

# HA settings
api_addr        = "http://127.0.0.1:8200"
cluster_addr    = "http://127.0.0.1:8201"
