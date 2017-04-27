package util;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.log4j.Logger;
import org.apache.log4j.spi.LoggerFactory;
import org.easyrec.model.core.web.Item;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by fansy on 2017/4/27.
 */
public class Utils {
    private static final Log logger = LogFactory.getLog(Utils.class);
    private static final String serverUrl ="http://localhost:8080";

    public static final String APIKEY ="0df6465975814c4a1876c60c3fac1d4c";
    public static final String token = "8d6ddde777ae7917dce2b7d0b8cdcab9";
    public static final String tenantid ="abc123";


    public static String getServer(){
        return serverUrl;
    }

    public static Map<String,String> item2Map(Item item){
        Map<String,String> params = new HashMap<>();
//        token=b08f41cfa92b430538146cf474116c6d&tenantid=EASYREC_DEMO&itemid=42&
// itemdescription=Fatboy%20Slim%20-%20The%20Rockafeller%20Skank&
// itemurl=/item/fatboyslim&itemimageurl=/img/covers/fatboyslim.jpg&itemtype=ITEM?
        params.put("apikey",Utils.APIKEY);
        params.put("token",Utils.token);
        params.put("tenantid",Utils.tenantid);
        params.put("itemid",item.getItemId());
        params.put("itemdescription",item.getDescription());
        params.put("itemurl",item.getUrl());
        params.put("itemimageurl",item.getImageUrl());
        params.put("itemtype",item.getItemType());
//        params.put("userid",item.get)
        logger.info("params: "+params.toString() );

        return params;
    }
}
