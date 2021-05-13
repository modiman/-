SELECT * FROM
(SELECT
            trace.trace_id,
            tag.id AS tag_id,
            tag.name AS tag_name,
            tag.tag_employee AS tag_employee ,
            area.name AS area_name,
            trace.area_begin_time,
            trace.area_leave_time
             FROM
             trace ,tag, `area`
            WHERE trace.tag_id = tag.id AND trace.area_id = area.id) AS t1
            LEFT JOIN employee ON t1.tag_employee = employee.employee_id
            WHERE tag_id = '1b1e7122-3b88-11eb-95c7-0c9d92c5a7d0'
       ALTER TABLE trace DROP FOREIGN KEY area_id;