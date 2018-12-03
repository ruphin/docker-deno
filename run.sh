#!/usr/bin/env bash
cd /app

if [ "$1" == "bash" ]; then
	echo "Running: $@"
	exec $@
else
	echo "Running: deno $@"
	exec deno $@
fi