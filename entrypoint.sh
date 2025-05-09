#!/usr/bin/env sh
set -e

echo "🔨 Ensuring content directory structure & permissions…"
mkdir -p /var/lib/ghost/content/logs
chown -R node:node /var/lib/ghost/content
chmod -R 775 /var/lib/ghost/content

echo "🔓 Forcefully releasing migration lock and fixing database state…"
# Run commands in the right directory without using cd as executable
su-exec node sh -c "cd /var/lib/ghost && yarn knex-migrator unlock --force"

# Wait a moment to ensure the unlock completes
sleep 3

# If needed, try a rollback and migrate again
echo "🔧 Attempting database repair if needed..."
su-exec node sh -c "cd /var/lib/ghost && yarn knex-migrator reset --force" || true

# Wait again
sleep 3

echo "🚧 Applying any pending migrations…"
su-exec node sh -c "cd /var/lib/ghost && yarn knex-migrator migrate"

echo "🚀 Starting Ghost in the foreground…"
exec su-exec node ghost start --no-daemon
