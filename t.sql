package com.jinglinsoft.rtle.api;

import com.eclipsesource.json.JsonArray;
import com.eclipsesource.json.JsonObject;
import com.eclipsesource.json.JsonValue;
import com.jinglinsoft.rtle.comm.Point;
import com.jltech.rtlstpl.util.Logger;
//import java.util.*;
import java.sql.DriverManager;
import java.sql.*;
import java.util.*;
import java.util.Date;

import com.jinglinsoft.rtle.api.Tag;
public class Tags {
    private static final Map<String, Tag> tagList = new Hashtable<>();
    public static final String PFILENAME_TAGS = "tags";
    public static final String PK_DATA = "data";
    public static final String PK_ID = "id";
    public static final String PK_NAME = "name";
    public static final String PK_ENABLED = "enabled";
    public static final String PK_BATTERY_VOLTAGE = "battery_voltage";
    public static final String PK_ICON = "icon";
    private static final Logger logger = Logger.getLogger(Tags.class);

    static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://localhost:3306/rtls";

    // MySQL 8.0 以上版本 - JDBC 驱动名及数据库 URL
    //static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    //static final String DB_URL = "jdbc:mysql://localhost:3306/RUNOOB?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";


    // 数据库的用户名与密码，需要根据自己的设置
    static final String USER = "root";
    static final String PASS = "123456";
    static {

        Connection conn = null;
        Statement stmt = null;

        try{
            // 注册 JDBC 驱动
            Class.forName(JDBC_DRIVER);

            // 打开链接
            System.out.println("连接数据库...");
            conn = DriverManager.getConnection(DB_URL,USER,PASS);

            // 执行查询
            System.out.println(" 实例化Statement对象...");
            stmt = conn.createStatement();
            String sql;
            sql = "SELECT *  FROM t_tags";
            ResultSet rs = stmt.executeQuery(sql);

            // 展开结果集数据库
            while(rs.next()){
                Tag tags = new Tag();
                // anchor = new Anchor();
                tags.setId(rs.getString("tags_id"));
                tags.setName(rs.getString("tags_name"));


                tags.setBatteryVoltage(rs.getDouble("tags_battery_voltage"));
                add(tags);
                // 通过字段检索

            }
            save();
            // 完成后关闭
            rs.close();
            stmt.close();
            conn.close();
        }catch(SQLException se){
            // 处理 JDBC 错误
            se.printStackTrace();
        }catch(Exception e){
            // 处理 Class.forName 错误
            e.printStackTrace();
        }finally{
            // 关闭资源
            try{
                if(stmt!=null) stmt.close();
            }catch(SQLException se2){
            }// 什么都不做
            try{
                if(conn!=null) conn.close();
            }catch(SQLException se){
                se.printStackTrace();
            }
        }
    }

    public Tags() {
    }

    public static synchronized void clear() {
        tagList.clear();
    }

    public static synchronized void add(Tag tag) {
        tagList.put(tag.getId(), tag);
    }

    public static synchronized void put(Tag tag) {
        tagList.put(tag.getId(), tag);
    }

    public static synchronized int size() {
        return tagList.size();
    }

    public static synchronized Set<String> keys() {
        return tagList.keySet();
    }

    public static synchronized Tag get(String tagId) {
        return tagList.get(tagId);
    }

    public static synchronized Map<String, Tag> getTagList() {
        return tagList;
    }

    public static synchronized void updateTag(boolean enable, String id, String name, String tagTypeId, String comments, String icon, boolean useAreaFilter, boolean useAverageFilter, double averageUnitTime, boolean useKalmanFilter, int kalmanFilterLevel) {
        Tag tag = get(id);
        if (tag == null) {
            tag = new Tag();
            tag.setId(id);
            add(tag);
        }

        tag.setEnable(enable);
        tag.setName(name);
        tag.setTagTypeId(tagTypeId);
        tag.setComments(comments);
        tag.setIcon(icon);
        tag.setUseAreaFilter(useAreaFilter);
        tag.setUseAverageFilter(useAverageFilter);
        tag.setAverageUnitTime(averageUnitTime);
        tag.setUseKalmanFilter(useKalmanFilter);
        tag.setKalmanFilterLevel(kalmanFilterLevel);
    }

    public static synchronized void updateTagLocate(String id, String areaId, long seq64, double x, double y, double z, double correctedX, double correctedY, double correctedZ, String outPutCoordareaId) {
        Tag tag = get(id);
        if (tag != null) {
            tag.setAreaId(areaId);
            tag.setSeq64(seq64);
            tag.setLastLocateTime(new Date());
            tag.setX(x);
            tag.setY(y);
            tag.setZ(z);
            tag.setCorrectedX(correctedX);
            tag.setCorrectedY(correctedY);
            tag.setCorrectedZ(correctedZ);
            tag.setOutPutCoordareaId(outPutCoordareaId);
            Point p = new Point(x, y, z);
            tag.addNewLocation(p);
            RTLEAPI.getRTLSEventMonitor().eventNotify(tag);
        }
    }

    public static synchronized void updateTagMessage(String id, long seq64, double blinkInterval, double powerVoltage, double batteryVoltage, double lighteness, short switchStatus, double imuAcceleroX, double imuAcceleroY, double imuAcceleroZ, double imuPitchAngle, double imuRollAngle, double imuYawAngle, double imuTemperature) {
        Tag tag = get(id);
        if (tag != null) {
            tag.setBlinkInterval(blinkInterval);
            tag.setLastMessageSeq64(seq64);
            tag.setLastLocateTime(new Date());
            tag.setBatteryVoltage(batteryVoltage);
            tag.setPowerVoltage(powerVoltage);
            tag.setLighteness(lighteness);
            tag.setSwitchStatus(switchStatus);
            tag.setImuAcceleroX(imuAcceleroX);
            tag.setImuAcceleroY(imuAcceleroY);
            tag.setImuAcceleroZ(imuAcceleroZ);
            tag.setImuPitchAngle(imuPitchAngle);
            tag.setImuRollAngle(imuRollAngle);
            tag.setImuYawAngle(imuYawAngle);
            tag.setImuTemperature(imuTemperature);
        }
    }

    public static synchronized void remove(String id) {
        tagList.remove(id);
//		RTLEClient.queueAddLast(new NET_MESSAGE_C2S_TAG_REMOVE_CLIENT(id));
    }

    private static void save() {
        JsonArray arr = new JsonArray();
        for (Tag tag : tagList.values()) {
            JsonObject item = new JsonObject();
            item.add(PK_ID, tag.getId());
            item.add(PK_NAME, tag.getName());
            item.add(PK_ENABLED, tag.isEnable());
            item.add(PK_BATTERY_VOLTAGE, tag.getBatteryVoltage());
            item.add(PK_ICON, tag.getIcon());
            arr.add(item);
        }
        if (!JsonUtil.toFile(new JsonObject().add(PK_DATA, arr), PFILENAME_TAGS))
            logger.warn("Tags not saved to json.");
    }

}
