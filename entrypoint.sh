#!/usr/bin/env sh
set -e

echo "🔨 Ensuring content directory structure & permissions…"
mkdir -p /var/lib/ghost/content/logs
chown -R node:node /var/lib/ghost/content
chmod -R 775 /var/lib/ghost/content

echo "🔓 Releasing any stuck migration lock…"
# Using the original command that was in your script, as it might be the correct path
su-exec node ghost run knex-migrator unlock

echo "🚧 Applying any pending migrations…"
su-exec node ghost run knex-migrator migrate

echo "🚀 Starting Ghost in the foreground…"
exec su-exec node ghost start --no-daemon
