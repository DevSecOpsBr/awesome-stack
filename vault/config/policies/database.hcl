# Dev servers have version 2 of KV mounted by default, so will need these
# paths:
path "secret/database/*" {
  capabilities = ["create"]
}

path "secret/database/users" {
  capabilities = ["read"]
}

path "secret/database/config/*" {
  capabilities = ["read","create","list","update","delete"]
}
