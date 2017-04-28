package recommend;

import model.Rating;
import util.HttpToolkit;
import util.Utils;

import java.util.HashMap;
import java.util.Map;

/**
 * 推荐示例
 *
 *
 parameter	occurence	description
 apikey	    required	API Key to access this service.(e.g. "8ab9dc3ffcdac576d0f298043a60517a")
 tenantid	required	tenant id to identify your Website. (e.g. "EASYREC_DEMO")
 itemid	    required	id to identify an item on your Website. (e.g. "ID001")
 userid	    optional	anonymised id of a user. (e.g. "24EH1723322222A3")
 numberOfResults	optional	parameter to determine the number of results returned.
 offset	    optional	An optional 0-based index to specify with which item to start the result - useful for paging.
 itemtype	optional; default: ITEM	item type that denotes the type of the item (e.g. IMAGE, VIDEO, BOOK, etc.) you are looking for. If not supplied the default value ITEM will be used.
 requesteditemtype	optional; default: ITEM	item type (e.g. IMAGE, VIDEO, BOOK, etc.) to filter the returned items. If not supplied the default value ITEM will be used.
 withProfile	optional	If this parameter is set to true the result contains an additional element 'profileData' with the item profile.
 *
 * Created by fanzhe on 2017/4/27.
 */
public class RecExample {


    public static void main(String[] args){
//        {yourServerURL}/api/1.1/recommendationsforuser?apikey=8ab9dc3ffcdac576d0f298043a60517a&
// tenantid=EASYREC_DEMO&userid=24EH1723322222A3&requesteditemtype=ITEM

        String url = Utils.getServer() +"/api/1.1/recommendationsforuser";
//        String url = Utils.getServer() +"/api/1.1/actionhistoryforuser";

        String userid= "1";

        Map<String, String> params = new HashMap<>();
        params.put("apikey",Utils.getValue("apikey"));
        params.put("tenantid",Utils.getValue("tenantid"));
        params.put("token",Utils.getValue("token"));


        params.put("userid",userid);
        params.put("requesteditemtype","ITEM");
        params.put("sessionid",Utils.getSessionId(userid));
        params.put("actiontype","VIEW");
        String result = HttpToolkit.doGet(url, params);

        Utils.printXMLStr( result);



    }
}
