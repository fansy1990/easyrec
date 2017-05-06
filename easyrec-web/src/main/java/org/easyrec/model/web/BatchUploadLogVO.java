package org.easyrec.model.web;

/**
 * Created by fanzhe on 2017/5/5.
 */
public class BatchUploadLogVO {
    private Integer id;

    private String fileType;
    private String fileName;
    private Integer lineCount;
    private String status;
    private Double time;
    private String message;
    private String tenantId;
    private String operatorId;
    private String token;
    private String apikey;

    public BatchUploadLogVO(){}
    public BatchUploadLogVO(Integer id,String fileType,String fileName,
                            Integer lineCount,String status,Double time,String message,
                            String tenantId,String operatorId,String token,String apikey){
        this.id = id;
        this.fileName= fileName;
        this.fileType = fileType;
        this.lineCount = lineCount;
        this.status = status;
        this.time = time;
        this.message = message;
        this.tenantId = tenantId;
        this.operatorId = operatorId;
        this.token = token;
        this.apikey = apikey;
    }
    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getFileType() {
        return fileType;
    }

    public void setFileType(String fileType) {
        this.fileType = fileType;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public Integer getLineCount() {
        return lineCount;
    }

    public void setLineCount(Integer lineCount) {
        this.lineCount = lineCount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Double getTime() {
        return time;
    }

    public void setTime(Double time) {
        this.time = time;
    }

    public String getTenantId() {
        return tenantId;
    }

    public void setTenantId(String tenantId) {
        this.tenantId = tenantId;
    }

    public String getOperatorId() {
        return operatorId;
    }

    public void setOperatorId(String operatorId) {
        this.operatorId = operatorId;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getApikey() {
        return apikey;
    }

    public void setApikey(String apikey) {
        this.apikey = apikey;
    }
}
