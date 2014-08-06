#!/bin/sh
##
# Keep local path in sync with remote path on server.
# Ignore .git metadata.
#
# Usage:
# $ watcher ~/Projects/Fun/moonbeam/ vagrant@my_remote:/vagrant/

local=$1
remote=$2
cmd="rsync -tziru --exclude .git $local $remote"

echo "Watching '$local' and syncing to '$remote'"
fswatch -o . | xargs -n1 -I{} $cmd
