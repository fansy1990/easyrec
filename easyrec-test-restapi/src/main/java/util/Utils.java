package util;

import model.Rating;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.log4j.Logger;
import org.apache.log4j.spi.LoggerFactory;
import org.easyrec.model.core.web.Item;

import javax.xml.transform.OutputKeys;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import java.io.*;
import java.util.*;

/**
 * Created by fansy on 2017/4/27.
 */
public class Utils {
    private static final Log logger = LogFactory.getLog(Utils.class);
    private static final String serverUrl ="http://localhost:8080";

//    public static final String APIKEY ="0df6465975814c4a1876c60c3fac1d4c";
//    public static final String APIKEY ="0df6465975814c4a1876c60c3fac1d4c";
//    public static final String token = "459021c3bdd85fb5930ac496cf3ebb78";
//    public static final String token = "8d6ddde777ae7917dce2b7d0b8cdcab9";
//    public static final String tenantid ="0123456abc";
//    public static final String tenantid ="abc123";

//    InputStream t = Utils.class.getClassLoader()
//            .getResourceAsInputStream("/car_params.properties");
    public static final String propertiesFile = "/tenant.properties";
    private static Map<String,String> properties = new HashMap<>();

    public static String getValue(String key){
        if(properties.size() < 1 ){
            try {
                Properties props = new Properties();
                InputStream in = new BufferedInputStream (Utils.class.getResourceAsStream(propertiesFile));
                props.load(in);
                properties.put("apikey",props.getProperty("apikey"));
                properties.put("token",props.getProperty("token"));
                properties.put("tenantid",props.getProperty("tenantid"));
                logger.info("初始化"+propertiesFile+"文件成功!");
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        }
        return properties.get(key);
    }


    public static String getServer(){
        return serverUrl;
    }

    public static Map<String,String> item2Map(Item item){
        Map<String,String> params = new HashMap<>();
//        token=b08f41cfa92b430538146cf474116c6d&tenantid=EASYREC_DEMO&itemid=42&
// itemdescription=Fatboy%20Slim%20-%20The%20Rockafeller%20Skank&
// itemurl=/item/fatboyslim&itemimageurl=/img/covers/fatboyslim.jpg&itemtype=ITEM?
        params.put("apikey",Utils.getValue("apikey"));
        params.put("token",Utils.getValue("token"));
        params.put("tenantid",Utils.getValue("tenantid"));

        params.put("itemid",item.getItemId());
        params.put("itemdescription",item.getDescription());
        params.put("itemurl",item.getUrl());
        params.put("itemimageurl",item.getImageUrl());
        params.put("itemtype",item.getItemType());
//        params.put("userid",item.get)
        logger.info("params: "+params.toString() );

        return params;
    }

    public static Map<String,String> rating2Map(Rating rating){
//        {yourServerURL}/api/1.1/sendaction?apikey=8ab9dc3ffcdac576d0f298043a60517a&
//                tenantid=EASYREC_DEMO&actiontype=PUT_INTO_SHOPPINGCART&itemid=42&
// itemdescription=Fatboy Slim%20-%20The%20Rockafeller%20Skank&itemurl=/item/fatboyslim&
// itemimageurl=/img/covers/fatboyslim.jpg&userid=24EH1723322222A3&
// sessionid=F3D4E3BE31EE3FA069F5434DB7EC2E34&actiontime=01_01_2009_23_59_59&itemtype=ITEM
        Map<String,String> params = new HashMap<>();
        params.put("apikey",Utils.getValue("apikey"));
        params.put("token",Utils.getValue("token"));
        params.put("tenantid",Utils.getValue("tenantid"));

        params.put("itemid",rating.getItemid());
        params.put("itemdescription",rating.getItemdescription());
        params.put("itemurl",rating.getItemurl());
        params.put("userid",rating.getUserid());
        params.put("itemimageurl",rating.getItemimageurl());
        params.put("actiontype",rating.getActiontype());
        params.put("actionvalue",rating.getActionvalue());
        params.put("itemtype",rating.getItemtype());
        params.put("actioninfo",rating.getActioninfo());
        params.put("sessionid",rating.getSessionid());

        logger.info("params: "+params.toString() );
        return params;
    }

    public static List<String> readFile(String filename) throws IOException {
        List<String> list = new ArrayList<>();
        System.out.println(new File(".").getAbsoluteFile());
        FileReader fr = new FileReader(filename);

        BufferedReader bf = new BufferedReader(fr);

        String line = null;
        while ((line=bf.readLine())!=null){
           list.add(line);
        }
        bf.close();
        fr.close();
        return list;
    }

    public static String getItemDesc(String itemid){
        return itemid+"Item";
    }
    public static String getItemUrl(String itemid){
        return "/item/"+itemid;
    }
    public static String getItemImgUrl(String itemid){
        return "/item/image/"+itemid;
    }
    public static String getSessionId(String userid){
        return userid.hashCode() +userid;
    }

    public static String currentTime(){
        return new Date().toString();
    }


    public static String prettyFormat(String input, int indent) {
        try {
            Source xmlInput = new StreamSource(new StringReader(input));
            StringWriter stringWriter = new StringWriter();
            StreamResult xmlOutput = new StreamResult(stringWriter);
            TransformerFactory transformerFactory = TransformerFactory.newInstance();
            transformerFactory.setAttribute("indent-number", indent);
            Transformer transformer = transformerFactory.newTransformer();
            transformer.setOutputProperty(OutputKeys.INDENT, "yes");
            transformer.transform(xmlInput, xmlOutput);
            return xmlOutput.getWriter().toString();
        } catch (Exception e) {
            throw new RuntimeException(e); // simple exception handling, please review it
        }
    }

    public static String prettyFormat(String input) {
        return prettyFormat(input, 2);
    }

    public static void printXMLStr(String input){
        System.out.println();
        System.out.println("========================");
        System.out.println(prettyFormat(input));
    }

    public static String getMovieDesc(String mid, String title, String genres) {
        return "movieId: "+mid +"\n" +
                "title: "+ title +"\n" +
                "genres: "+ genres;
    }
}
