SELECT  t1.trace_id ,
		t1. tag_id,
		t1.tag_name,
		t1.area_id ,
		area.name
FROM  (SELECT 
		trace.trace_id ,
		tag.id AS tag_id,
		tag.name AS tag_name,
		trace.area_id 
		FROM trace LEFT JOIN tag  ON trace.tag_id = tag.id) AS t1
LEFT JOIN `area` 
ON t1.area_id = area.id
