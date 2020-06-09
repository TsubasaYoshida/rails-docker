#!/bin/bash
set -e

rm -f /rails-docker/tmp/pids/server.pid

exec "$@"
