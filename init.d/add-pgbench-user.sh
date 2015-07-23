#!/bin/bash

source /docker-entrypoint-initdb.d/functions

echo
echo '****** Creating PgBench User And Database ******'

pg_exec "create user pgbench with password '$PGBENCH_PASSWORD'"
pg_exec "create database pgbench"
pg_exec "grant ALL ON DATABASE pgbench to pgbench"

echo
