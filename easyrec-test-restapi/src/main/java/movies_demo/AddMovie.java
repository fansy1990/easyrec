package movies_demo;

import model.Rating;
import org.easyrec.model.core.web.Item;
import util.HttpToolkit;
import util.Utils;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by fanzhe on 2017/5/1.
 */
public class AddMovie {
    public static final String COLON="::";
    public static void main(String[] args) throws IOException {
        String filename = "easyrec-test-restapi/src/main/java/movies_demo/movies.dat";
        String url = Utils.getServer() +"/api/1.1/sendaction";
        for(Item item :getMovies(filename)) {
            Map<String, String> params = Utils.item2Map(item);
            String result = HttpToolkit.doGet(url, params);
            System.out.println("result:" + result);
        }
    }

    private static List<Item> getMovies(String filename) throws IOException {
        List<Item> items = new ArrayList<>();
//        movies:
//        mid,title,genres
        List<String> lines = Utils.readFile(filename);

        String[] data = null;
        String mid ,title,genres;

        for(String line : lines){
            data = line.split(COLON);
            mid = data[0];
            title= data[1];
            genres = data[2];
            //        Item(String id, Integer tenantId, String itemId, String itemType,
            // String description, String url,
//                String imageUrl, Double value, boolean active, String creationDate)
            items.add(new Item("1",1,mid,"ITEM",Utils.getMovieDesc(mid, title, genres),
                    Utils.getItemUrl(mid),Utils.getItemImgUrl(mid),0.0,true,Utils.currentTime()));

        }


        return items;
    }
}
