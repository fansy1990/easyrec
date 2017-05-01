package actions;

import model.Rating;
import util.HttpToolkit;
import util.Utils;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by fanzhe on 2017/5/1.
 */
public class AddTrack {
    public static void main(String[] args){
        String url = Utils.getServer() +"/api/1.1/track";


//        GET /api/1.1/json/track?
// apikey=0df6465975814c4a1876c60c3fac1d4c&tenantid=abc00&sessionid=&
// userid=&itemfromid=&itemfromtype=&itemtoid=&itemtotype=&rectype=&token=
        Map<String, String> params = new HashMap<String,String>();
        params.put("apikey",Utils.getValue("apikey"));
        params.put("token",Utils.getValue("token"));
        params.put("tenantid",Utils.getValue("tenantid"));

        params.put("sessionid",Utils.getSessionId("1"));
        params.put("userid","1");
        params.put("itemfromid","101");
        params.put("itemtoid","107");
        params.put("rectype","RECS_FOR_USER");

        String result = HttpToolkit.doGet(url, params);
        System.out.println("result:" + result);

    }
}
