#!/bin/bash
set -e

cron

exec docker-entrypoint.sh "$@"