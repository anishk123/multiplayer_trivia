#!/bin/sh
set -e
rm -f /project/tmp/pids/server.pid
exec "$@"