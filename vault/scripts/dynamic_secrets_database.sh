#!/bin/bash

USERNAME=drone_user
PASSWORD=drone_password
PG_DB=postgres

CONTAINER_DB=$(docker container ps -f=name=droneci_db -q)
POLICIES="../policies"
GH_ORG="DevSecOpsBr"

(
  # Dynamic Secrets: Database Secrets Engine
  docker container exec -it $CONTAINER_DB psql -U $USERNAME $PG_DB -c "CREATE ROLE \"ro\" NOINHERIT;"
  docker container exec -it $CONTAINER_DB psql -U $USERNAME $PG_DB -c "GRANT SELECT ON ALL TABLES IN SCHEMA public TO \"ro\";"
  docker container exec -it $CONTAINER_DB psql -U $USERNAME $PG_DB -c "CREATE DATABASE junttus;"

  vault secrets enable database
  vault secrets list -detailed
  sleep 5

  POSTGRES_URL='droneci_db'
  vault write database/config/postgresql \
  plugin_name=postgresql-database-plugin \
  connection_url="postgresql://{{username}}:{{password}}@$POSTGRES_URL/$PG_DB?sslmode=disable" \
  allowed_roles=* \
  username="$USERNAME" \
  password="$PASSWORD"
  sleep 5

  tee readonly.sql <<EOF
CREATE ROLE "{{name}}" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}' INHERIT;
GRANT ro TO "{{name}}";
GRANT SELECT ON ALL TABLES IN SCHEMA public TO "{{name}}";
EOF

  vault write database/roles/readonly \
  db_name=postgresql \
  creation_statements=@readonly.sql \
  default_ttl=1h \
  max_ttl=24h
  rm readonly.sql

  vault read database/creds/readonly

  docker container exec -it $CONTAINER_DB psql -U $USERNAME $PG_DB -c "SELECT usename, valuntil FROM pg_user;"

  vault list sys/leases/lookup/database/creds/readonly
  LEASE_ID=$(vault list -format=json sys/leases/lookup/database/creds/readonly | jq -r ".[0]")
  vault lease renew database/creds/readonly/$LEASE_ID
  vault lease revoke database/creds/readonly/$LEASE_ID
  vault list sys/leases/lookup/database/creds/readonly
  vault read database/creds/readonly
  vault lease revoke -prefix database/creds/readonly
  vault list sys/leases/lookup/database/creds/readonly

  tee db_password_policy.hcl <<EOF
length=20

rule "charset" {
  charset = "abcdefghijklmnopqrstuvwxyz"
  min-chars = 1
}

rule "charset" {
  charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  min-chars = 1
}

rule "charset" {
  charset = "0123456789"
  min-chars = 1
}

rule "charset" {
  charset = "!@#$%^&*"
  min-chars = 1
}
EOF
  vault write sys/policies/password/db_password policy=@db_password_policy.hcl
  vault read sys/policies/password/db_password/generate
  vault write database/config/postgresql \
     password_policy="db_password"
  vault read database/creds/readonly
  vault write database/config/postgresql \
    username_template="myorg-{{.RoleName}}-{{unix_time}}-{{random 8}}"
  vault read database/creds/readonly
  rm db_password_policy.hcl
)

(
  tee db_creds.hcl <<EOF
path "database/creds/readonly" {
  capabilities = [ "read" ]
}

path "sys/leases/renew" {
  capabilities = [ "update" ]
}
EOF

  vault policy write db_creds db_creds.hcl
  rm db_creds.hcl
  DB_TOKEN=$(vault token create -policy="db_creds" -format json | jq -r '.auth | .client_token')

)
