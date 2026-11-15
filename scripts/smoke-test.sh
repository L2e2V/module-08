#!/usr/bin/env bash
set -euo pipefail

IMAGE="${1:?Usage: smoke-test.sh IMAGE}"
CONTAINER_NAME="dummy-exporter-smoke-$$"

cleanup() {
    docker rm -f "$CONTAINER_NAME" >/dev/null 2>&1 || true
}

trap cleanup EXIT

echo "Starting image: $IMAGE"

docker run -d \
    --name "$CONTAINER_NAME" \
    "$IMAGE" >/dev/null

echo "Waiting for exporter..."

READY=0

for attempt in $(seq 1 30); do
    if docker run --rm \
        --network "container:$CONTAINER_NAME" \
        curlimages/curl:8.12.1 \
        -fsS http://127.0.0.1:9510/metrics \
        -o /dev/null; then
        READY=1
        break
    fi

    sleep 1
done

if [ "$READY" -ne 1 ]; then
    echo "ERROR: Exporter did not become ready"
    docker logs "$CONTAINER_NAME"
    exit 1
fi

echo "Exporter is ready"

METRICS=$(docker run --rm \
    --network "container:$CONTAINER_NAME" \
    curlimages/curl:8.12.1 \
    -fsS http://127.0.0.1:9510/metrics)

echo "$METRICS" | grep -q '^# TYPE dummy_foo gauge$'
echo "$METRICS" | grep -q '^# TYPE dummy_bar counter$'

echo "Smoke test passed"
