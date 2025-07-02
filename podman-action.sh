#!/bin/bash
set -e
TARGET="$1"
IMAGE="ghcr.io/emblem-66/test2:$TARGET"

podman build -f Containerfile -t "$IMAGE" --target "$TARGET" .
podman push "$IMAGE"
