package actions;

import model.Rating;
import util.HttpToolkit;
import util.Utils;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by fansy on 2017/4/27.
 */
public class AddView {
    public static void main(String[] args) throws IOException, InterruptedException {
        String filename = "easyrec-test-restapi/src/main/java/actions/data.csv";
        String url = Utils.getServer() + "/api/1.1/sendaction";
        for (Rating rating : getRatings(filename)) {
            Map<String, String> params = Utils.rating2Map(rating);
            Thread.sleep(1500);
            String result = HttpToolkit.doGet(url, params);
            System.out.println("result:" + result);
        }
    }

    private static List<Rating> getRatings(String filename) throws IOException {
        List<Rating> ratingList = new ArrayList<>();

        String[] data;
        String userid;
        String itemid;
        String pref;
        for (String line : Utils.readFile(filename)) {
            // line = 5,106,4.0
            data = line.split(",");
            userid = data[0];
            itemid = data[1];
            pref = data[2];
//             public Rating(String itemid,String itemdescription,
//            String itemurl, String userid,
//                    String itemimageurl,String actiontype,
//                    String actionvalue,String actiontime,
//                    String itemtype,String actioninfo,String sessionid){
            ratingList.add(new Rating(itemid, Utils.getItemDesc(itemid),
                    Utils.getItemUrl(itemid), userid,
                    Utils.getItemImgUrl(itemid), "VIEW",
                    String.valueOf(Double.parseDouble(pref) * 2), Utils.currentTime(),
                    "ITEM", "", Utils.getSessionId(userid)
            ));
        }

        return ratingList;
    }
}