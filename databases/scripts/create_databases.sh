#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
	CREATE USER drone_bb;
	CREATE DATABASE drone_bitbucket;
	GRANT ALL PRIVILEGES ON DATABASE drone_bitbucket TO drone_bb;
EOSQL

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
	CREATE USER drone_gh;
	CREATE DATABASE drone_github;
	GRANT ALL PRIVILEGES ON DATABASE drone_github TO drone_gh;
EOSQL

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
	CREATE USER gitness;
	CREATE DATABASE gitness;
	GRANT ALL PRIVILEGES ON DATABASE gitness TO gitness;
EOSQL

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
	CREATE USER gitea;
	CREATE DATABASE gitea;
	GRANT ALL PRIVILEGES ON DATABASE gitea TO gitea;
EOSQL
