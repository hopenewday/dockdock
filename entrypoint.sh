#!/usr/bin/env sh
set -e

echo "🔓 Releasing any stuck migration lock…"
# ← Replace the yarn call with Ghost-CLI’s wrapper:
ghost run knex-migrator unlock

echo "🚀 Starting Ghost in the foreground…"
# ← Use exec so signals (SIGTERM/SIGINT) are forwarded correctly:
exec ghost start --no-daemon
