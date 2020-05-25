#!/bin/sh

for f in docker/*.conf; do
    sed -ri "s/%hostname%/$domain/" $f
done

docker-compose -f docker/bootstrap/bootstrap.yaml up
