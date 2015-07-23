#!/bin/bash

source /docker-entrypoint-initdb.d/functions

echo
echo '********** Creating DataDog User **********'

pg_exec "create user datadog with password '$DATADOG_PG_PASSWORD'" 
pg_exec "grant SELECT ON pg_stat_database to datadog"

echo
