#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
docker-compose up -d postgres
make forced-clean-sql
docker-compose run --rm import-water
docker-compose run --rm import-osmborder
docker-compose run --rm import-natural-earth
docker-compose run --rm import-lakelines
#docker-compose run --rm import-osm
#docker-compose run --rm import-sql
#make psql-analyze
