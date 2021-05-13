SHOW CREATE TABLE trace

CREATE TABLE `trace` (
  `trace_id` VARCHAR(255) NOT NULL,
  `tag_id` VARCHAR(255) DEFAULT NULL,
  `area_begin_time` DATETIME DEFAULT NULL,
  `axis_x` DOUBLE DEFAULT NULL,
  `axis_y` DOUBLE DEFAULT NULL,
  `area_leave_time` VARCHAR(255) DEFAULT NULL,
  `area_id` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`trace_id`),
  KEY `FK6i69l8q1rwxaipq8jbkncm3dr` (`tag_id`),
  KEY `FK8sp5q10twd39bafljipjobgrn` (`area_id`),
  CONSTRAINT `FK6i69l8q1rwxaipq8jbkncm3dr` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`),
  CONSTRAINT `FK8sp5q10twd39bafljipjobgrn` FOREIGN KEY (`area_id`) REFERENCES `area` (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8

      ALTER TABLE trace DROP area_leave_time