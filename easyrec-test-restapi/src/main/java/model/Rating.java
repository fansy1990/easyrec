package model;

/**
 * Created by fanzhe on 2017/4/27.
 */
public class Rating {
    public String getSessionid() {
        return sessionid;
    }

    public void setSessionid(String sessionid) {
        this.sessionid = sessionid;
    }

    private String sessionid;
    public Rating(){}
    public Rating(String itemid,String itemdescription,
                  String itemurl, String userid,
                  String itemimageurl,String actiontype,
                  String actionvalue,String actiontime,
                  String itemtype,String actioninfo,String sessionid){
        this.itemdescription = itemdescription;
        this.itemid = itemid;
        this.itemurl = itemurl;
        this.userid = userid;
        this.itemimageurl = itemimageurl;
        this.actiontype = actiontype;
        this.actionvalue= actionvalue;
        this.actiontime = actiontime;
        this.itemtype = itemtype;
        this.actioninfo = actioninfo;
        this.sessionid= sessionid;
    }

    public String getItemid() {
        return itemid;
    }

    public void setItemid(String itemid) {
        this.itemid = itemid;
    }

    public String getItemdescription() {
        return itemdescription;
    }

    public void setItemdescription(String itemdescription) {
        this.itemdescription = itemdescription;
    }

    public String getItemurl() {
        return itemurl;
    }

    public void setItemurl(String itemurl) {
        this.itemurl = itemurl;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getItemimageurl() {
        return itemimageurl;
    }

    public void setItemimageurl(String itemimageurl) {
        this.itemimageurl = itemimageurl;
    }

    public String getActiontype() {
        return actiontype;
    }

    public void setActiontype(String actiontype) {
        this.actiontype = actiontype;
    }

    public String getActionvalue() {
        return actionvalue;
    }

    public void setActionvalue(String actionvalue) {
        this.actionvalue = actionvalue;
    }

    public String getActiontime() {
        return actiontime;
    }

    public void setActiontime(String actiontime) {
        this.actiontime = actiontime;
    }

    public String getItemtype() {
        return itemtype;
    }

    public void setItemtype(String itemtype) {
        this.itemtype = itemtype;
    }

    public String getActioninfo() {
        return actioninfo;
    }

    public void setActioninfo(String actioninfo) {
        this.actioninfo = actioninfo;
    }

    private String itemid;
    private String itemdescription;
    private String itemurl;
    private String userid;
    private String itemimageurl;
    private String actiontype;
    private String actionvalue;
    private String actiontime;
    private String itemtype;
    private String actioninfo;
}
