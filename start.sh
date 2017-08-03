#!/usr/bin/env bash

set -e

# wait 15s for db
/scripts/wait-for-it.sh "${DB_HOST}:${DB_PORT}" --strict

# TODO do we need to copy deployments after DS setup?

${JBOSS_HOME}/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0
