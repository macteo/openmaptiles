docker-compose up -d postgres

docker run --rm -v $(pwd):/tileset openmaptiles/openmaptiles-tools make clean
docker run --rm -v $(pwd):/tileset openmaptiles/openmaptiles-tools make

docker-compose run import-water
docker-compose run import-natural-earth
docker-compose run import-lakelines
docker-compose run import-osmborder

docker-compose run import-contour

docker-compose run import-osm
docker-compose run import-sql

docker-compose run generate-vectortiles

docker-compose run --rm openmaptiles-tools  generate-metadata ./data/tiles.mbtiles
docker-compose run --rm openmaptiles-tools  chmod 666         ./data/tiles.mbtiles	

make start-tileserver