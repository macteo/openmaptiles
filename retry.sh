docker rm -f $(docker ps -l -q)
docker-compose up -d postgres
docker run --rm -v $(pwd):/tileset openmaptiles/openmaptiles-tools make clean
docker run --rm -v $(pwd):/tileset openmaptiles/openmaptiles-tools make
docker-compose run --rm import-osm
docker-compose run --rm import-sql
make psql-analyze