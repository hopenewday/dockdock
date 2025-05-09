#!/usr/bin/env sh
set -e

echo "🔓 Releasing any stuck migration lock…"
# run migrator as the unprivileged 'node' user
su-exec node ghost run knex-migrator unlock

echo "🚀 Starting Ghost in the foreground…"
# exec so PID 1 is Ghost; also run as 'node'
exec su-exec node ghost start --no-daemon
