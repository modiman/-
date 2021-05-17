/*
SQLyog Community v13.1.6 (64 bit)
MySQL - 5.6.10-log 
*********************************************************************
*/
/*!40101 SET NAMES utf8 */;

create table `t_anchors` (
        `anchors_name` varchar (765),
        `anchors_serialno` varchar (765),
        `anchors_comments` varchar (765),
        `anchors_x` varchar (765),
        `anchors_y` varchar (765),
        `anchors_z` varchar (765),
        `anchors_ip` varchar (765),
        `anchors_mac` varchar (765),
        `anchors_enabled` varchar (765),
        `anchors_online` varchar (765)
        );
        insert into `tb_anchors` (`anchors_id`, `anchors_name`, `anchors_serialno`, `anchors_comments`, `anchors_x`, `anchors_y`, `anchors_z`, `anchors_ip`, `anchors_mac`, `anchors_enabled`, `anchors_online`) values('1','anchors1','1','ddd','1','2','3','127.0.0.1','df::ff','true','true');
        insert into `tb_anchors` (`anchors_id`, `anchors_name`, `anchors_serialno`, `anchors_comments`, `anchors_x`, `anchors_y`, `anchors_z`, `anchors_ip`, `anchors_mac`, `anchors_enabled`, `anchors_online`) values('2','anchors2','2','da','2','3','4','123.123.132.0','dd:ds','true','true');
        insert into `tb_anchors` (`anchors_id`, `anchors_name`, `anchors_serialno`, `anchors_comments`, `anchors_x`, `anchors_y`, `anchors_z`, `anchors_ip`, `anchors_mac`, `anchors_enabled`, `anchors_online`) values('3','anchors3','3','ddd','3','30','40','#','#','true','true');
        insert into `tb_anchors` (`anchors_id`, `anchors_name`, `anchors_serialno`, `anchors_comments`, `anchors_x`, `anchors_y`, `anchors_z`, `anchors_ip`, `anchors_mac`, `anchors_enabled`, `anchors_online`) values('4','anchors4','4','ddd','4','40','50','#','#','true','true');
        insert into `tb_anchors` (`anchors_id`, `anchors_name`, `anchors_serialno`, `anchors_comments`, `anchors_x`, `anchors_y`, `anchors_z`, `anchors_ip`, `anchors_mac`, `anchors_enabled`, `anchors_online`) values('5','anchors5','5','gdsg','5','50','60','#','#','true',null);
