#!/usr/bin/env sh
set -e

echo "🔓 Releasing any stuck migration lock…"
yarn knex-migrator unlock

echo "🚀 Starting Ghost in the foreground…"
ghost start --no-daemon
