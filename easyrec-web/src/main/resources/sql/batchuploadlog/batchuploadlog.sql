
-- # 数据导入日志

CREATE TABLE batchuploadlog (
  id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  fileType VARCHAR(150) DEFAULT 'ITEM',
  fileName VARCHAR(500) NOT NULL,
  lineCount INT(30) NOT NULL,
  status VARCHAR(150) DEFAULT '',
  time DOUBLE  NOT NULL,
  message VARCHAR(500) ,
  tenantId VARCHAR(50) NOT NULL ,
  operatorId VARCHAR(50) NOT NULL ,
  token VARCHAR(50) NOT NULL ,
  apikey VARCHAR(50) NOT NULL ,
  PRIMARY KEY (id)
) ENGINE=INNODB DEFAULT CHARSET=utf8 COMMENT='Table containing batch upload logs';


-- private Integer id;
--     private String fileType;
--     private String fileName;
--     private Integer lineCount;
--     private String status;
--     private Long time;
--     private String message;
-- private String tenantId;
--     private String operatorId;
--     private String token;
--     private String apikey;