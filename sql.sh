docker run --rm -v $(pwd):/tileset openmaptiles/openmaptiles-tools make clean
docker run --rm -v $(pwd):/tileset openmaptiles/openmaptiles-tools make
docker-compose run --rm import-sql