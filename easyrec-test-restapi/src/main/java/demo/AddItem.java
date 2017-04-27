package demo;

import org.easyrec.model.core.web.Item;
import util.HttpToolkit;
import util.Utils;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 parameter	          occurence          	description
 token	    required	The required security token ("b08f41cfa92b430538146cf474116c6d") to access this service.This token is only valid for the current session.Note: The token invalidates, if you sign out.
 tenantid	required	tenant id to identify your Website. (e.g. "EASYREC_DEMO")
 itemid	    required	id to identify an item on your Website. (e.g. "ID001")
 itemdescription    required	item description that is displayed when showing recommendations on your Website. (e.g. "the frog")
 itemurl	required	url that links to the item page on your Website.Note:Please encode &'s in url with %26
 userid	    optional	An optional anonymised id of a user. (e.g. "24EH1723322222A3")
 itemimageurl   optional	An optional item image url that links to a image of the item.Note:Please encode timestamp of the action.The parameter has the format "dd_MM_yyyy_HH_mm_ss" (e.g."01_01_2009_23_59_59").
 itemtype	optional; default:ITEM An optional item type that denotes the type of the item(e.g. IMAGE, VIDEO, BOOK, etc.).
 * Created by fansy on 2017/4/27.
 */
public class AddItem {
    /**
     * 放入ITEM汇总
     * itemid      itemdesc     itemurl     userid      itemimgurl      itemtype
     * 101          101Item     /item/101                               ITEM
     * 102          102Item     /item/102                               ITEM
     * 103          103Item     /item/103                               ITEM
     * 104          104Item     /item/104                               ITEM
     * 105          105Item     /item/105                               ITEM
     * 106          106Item     /item/106                               ITEM
     * 107          107Item     /item/107                               ITEM
     * @param args
     */
    public static void main(String[] args) {
        String url = Utils.getServer() +"/api/1.1/importitem";
        for(Item item :getItems()) {
            Map<String, String> params = Utils.item2Map(item);
            String result = HttpToolkit.doGet(url, params);
            System.out.println("result:" + result);
        }
    }
    public static Item[] getItems(){
        //        Item(String id, Integer tenantId, String itemId, String itemType, String description, String url,
//                String imageUrl, Double value, boolean active, String creationDate)
//        Item item1 = new Item("1",1,"101","ITEM","101Item","/item/101","",0.0,true,new Date().toString());
//        Item item2 = new Item("1",2,"102","ITEM","102Item","/item/102","",0.0,true,new Date().toString());
//        Item item3 = new Item("1",1,"102","ITEM","102Item","/item/102","",0.0,true,new Date().toString());
//        Item item4 = new Item("1",1,"102","ITEM","102Item","/item/102","",0.0,true,new Date().toString());
//        Item item5 = new Item("1",1,"102","ITEM","102Item","/item/102","",0.0,true,new Date().toString());
//        Item item6 = new Item("1",1,"102","ITEM","102Item","/item/102","",0.0,true,new Date().toString());
//        Item item7 = new Item("1",1,"102","ITEM","102Item","/item/102","",0.0,true,new Date().toString());
//
        Item[] items = new Item[7];
        for(int i = 1;i <= items.length;i++){
            items[i-1] = new Item("1",1,"10"+i,"ITEM","10"+i+"Item","/item/10"+i,"",0.0,true,new Date().toString());
        }
        return items;
    }
}
