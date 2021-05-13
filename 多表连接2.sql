
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


SELECT
            trace.trace_id,
            tag.id AS tag_id,
            tag.name,
            area.name,
            trace.area_begin_time,
            trace.area_leave_time
FROM
trace ,tag, `area`
WHERE trace.tag_id = tag.id AND trace.area_id = area.id
    
    
SELECT t1.tname,t1.mres,t2.tname,t1.time FROM 
(SELECT m.mid,t.tname,m.mres,m.matime AS TIME FROM m LEFT JOIN t ON t.tid = m.hid) 
AS t1 
LEFT JOIN 
(SELECT m.mid,t.tname,m.mres,m.matime AS TIME FROM m LEFT JOIN t ON t.tid = m.gid) 
AS t2 
ON t1.mid = t2.mid WHERE t1.time BETWEEN '2006-06-01' AND '2006-07-01';
