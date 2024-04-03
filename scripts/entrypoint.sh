#!/bin/bash

chmod +x /scripts/wait-for-kafka.sh
. /scripts/wait-for-kafka.sh

command="${1:-}"

exec "$@"
