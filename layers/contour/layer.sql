CREATE OR REPLACE VIEW contour_z8toz9 AS
    SELECT id AS osm_id, elevation as ele, geometry
    FROM contour_lines_gen0
	WHERE ((cast(elevation as integer)%100) = 0);

CREATE OR REPLACE VIEW contour_z10toz11 AS
    SELECT id AS osm_id, elevation as ele, geometry
    FROM contour_lines_gen0
	WHERE ((cast(elevation as integer)%50) = 0);

CREATE OR REPLACE VIEW contour_z12toz13 AS
    SELECT id AS osm_id, elevation as ele, geometry
    FROM contour_lines_gen1;

CREATE OR REPLACE VIEW contour_z14 AS
    SELECT id AS osm_id, elevation as ele, geometry
    FROM contour_lines;

CREATE OR REPLACE FUNCTION layer_contour(bbox geometry, zoom_level integer)
RETURNS TABLE(osm_id bigint, ele double precision, geometry geometry) AS $$

SELECT osm_id, ele, geometry FROM (
SELECT cast(osm_id as bigint), ele, geometry FROM contour_z8toz9   WHERE zoom_level BETWEEN 8 AND 9
  UNION ALL
SELECT cast(osm_id as bigint), ele, geometry FROM contour_z10toz11 WHERE zoom_level BETWEEN 10 AND 11
  UNION ALL
SELECT cast(osm_id as bigint), ele, geometry FROM contour_z12toz13 WHERE zoom_level BETWEEN 12 AND 13
  UNION ALL
SELECT cast(osm_id as bigint), ele, geometry FROM contour_z14      WHERE zoom_level = 14
) AS contour
WHERE geometry && bbox;

$$ LANGUAGE SQL IMMUTABLE;
