#!/bin/bash

mv /postgresql.conf ${PGDATA}/postgresql.conf
chown root:postgres ${PGDATA}/postgresql.conf
chmod 644 ${PGDATA}/postgresql.conf
