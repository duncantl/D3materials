uk.json:

subunits.json:  ne_10m_admin_0_map_subunits.shp
	ogr2ogr -f GeoJSON -where "ADM0_A3 IN ('GBR', 'IRL')" subunits.json  ne_10m_admin_0_map_subunits.shp

places.json: ne_10m_populated_places.shp
	ogr2ogr -f GeoJSON \
	    -where "ISO_A2 = 'GB' AND SCALERANK < 8" \
	    places.json \
	    ne_10m_populated_places.shp

uk.json: places.json subunits.json
	topojson -o uk.json --id-property SU_A3  --properties name=NAME --  subunits.json   places.json

#ne_10m_admin_0_map_subunits.shp: ne_10m_admin_0_map_subunits.zip
#	unzip ne_10m_admin_0_map_subunits.zip $@

%.shp: %.zip
	unzip $< 