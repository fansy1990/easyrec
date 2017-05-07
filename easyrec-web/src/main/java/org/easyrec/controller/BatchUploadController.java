/*

 */
package org.easyrec.controller;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.easyrec.model.core.web.Item;
import org.easyrec.model.core.web.Operator;
import org.easyrec.model.core.web.RemoteTenant;
import org.easyrec.model.core.web.Session;
import org.easyrec.model.web.BatchUploadLogVO;
import org.easyrec.model.web.FileUploadBean;
import org.easyrec.model.web.UploadRating;
import org.easyrec.plugin.container.PluginRegistry;
import org.easyrec.service.core.TenantService;
import org.easyrec.service.web.nodomain.ShopRecommenderService;
import org.easyrec.store.dao.core.ItemDAO;
import org.easyrec.store.dao.plugin.PluginDAO;
import org.easyrec.store.dao.web.BatchUploadLogDAO;
import org.easyrec.store.dao.web.OperatorDAO;
import org.easyrec.store.dao.web.RemoteTenantDAO;
import org.easyrec.util.core.Security;
import org.easyrec.utils.MyUtils;
import org.easyrec.utils.servlet.ServletUtils;
import org.easyrec.vocabulary.MSG;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.validation.BindException;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;


/**
 * This controller provides file upload for the webapp.
 * <p/>
 * <p><b>Company:&nbsp;</b>
 * SAT, Research Studios Austria</p>
 * <p/>
 * <p><b>Copyright:&nbsp;</b>
 * (c) 2010</p>
 * <p/>
 * <p><b>last modified:</b><br/>
 * $Author: phlavac $<br/>
 * $Date: 2010-03-24 18:37:33 +0100 (Mi, 24 Mrz 2010) $<br/>
 * $Revision: 15881 $</p>
 *
 * @author Stephan Zavrel
 */
public class BatchUploadController extends SimpleFormController implements ApplicationContextAware {
    private final Log logger = LogFactory.getLog(this.getClass());

    private ApplicationContext appContext;
    private PluginRegistry pluginRegistry;
    private BatchUploadLogDAO batchUploadLogDAO;
    private OperatorDAO operatorDAO;
    private ItemDAO itemDAO;
    private  ShopRecommenderService shopRecommenderService;

    private TenantService tenantService;
    private RemoteTenantDAO remoteTenantDAO;

    private Session session;
    private String dateFormat ="yyyy-MM-dd HH:mm:ss";

    @Override
    protected ModelAndView onSubmit(HttpServletRequest request, HttpServletResponse response, Object command,
                                    BindException errors) throws Exception {

        String tenantId = ServletUtils.getSafeParameter(request, "tenantId", "");
        String operatorId = ServletUtils.getSafeParameter(request, "operatorId", "");
        String token = Security.getSecurityToken(request);

        session = new Session(request.getSession().getId(),request.getRemoteAddr());

        Operator operator = operatorDAO.get(operatorId);

        Integer coreTenantId =null;
        coreTenantId = operatorDAO.getTenantId(operator.getApiKey(), tenantId);

        String fileType = ServletUtils.getSafeParameter(request, "fileType", "");

        logger.info("BatchUploadController: submit called, fileType:"+fileType);

        // cast the fubean
        FileUploadBean fubean = (FileUploadBean) command;
        if (fubean == null || fubean.getFile() == null || fubean.getFile().isEmpty()) {
            logger.info("no file or empty file was uploaded, aborting");
            // well, let's do nothing with the fubean for now and return
            return super.onSubmit(request, response, command, errors);
        }
        // check if there's content there
        MultipartFile file = fubean.getFile();
//        PluginVO plugin = pluginRegistry.checkPlugin(file.getBytes());

        BatchUploadLogVO batchUploadLog = new BatchUploadLogVO();
        try {
            batchUploadLog.setFileType(fileType);
            batchUploadLog.setApikey(operator.getApiKey());
            batchUploadLog.setTenantId(tenantId);
            batchUploadLog.setToken(token);

            importData(file.getBytes(), batchUploadLog,coreTenantId);

        }catch(Exception e){
            logger.error("Import data error",e);
        }

        // 保存 到数据库中
        batchUploadLog.setFileName(file.getOriginalFilename());
        batchUploadLog.setOperatorId(operatorId);

        batchUploadLogDAO.storeBatchUploadLog(batchUploadLog);

        ModelAndView mav = new ModelAndView("dev/page");

        mav.addObject("title", "华联云谷::管理员");

        mav.addObject("operatorId", operatorId);
        mav.addObject("tenantId", tenantId);
        mav.addObject("signedinOperatorId", Security.signedInOperatorId(request));

        mav.addObject("page", "batch");
        List<BatchUploadLogVO> logs = batchUploadLogDAO.loadBatchUploadLogsByOperator(operatorId);
        mav.addObject("logList", logs);


        return mav;

        // well, let's do nothing with the fubean for now and return
        //return super.onSubmit(request, response, command, errors);
    }

    /**
     * 遍历数据，并导入
     * @param file
     * @param batchUploadLog
     * @param coreTenantId
     * @return
     * @throws IOException
     */
    private void importData(byte[] file, BatchUploadLogVO batchUploadLog, Integer coreTenantId) throws IOException {

        FileOutputStream fos = null;
        File tmpFile = null;

        try {
            if (file == null) throw new IllegalArgumentException("Passed file must not be null!");

            tmpFile = File.createTempFile("batch_upload_file_folder", null);
            tmpFile.deleteOnExit();

            fos = new FileOutputStream(tmpFile);
            fos.write(file);
            fos.close();

            updateItem(batchUploadLog, tmpFile,coreTenantId);

        } catch (Exception e) {
            logger.error("An Exception occurred while importing Data !", e);

            throw e;
        } finally {
            if (fos != null)
                fos.close();

            if (tmpFile != null)
                try {
                    if (!tmpFile.delete()) logger.warn("could not delete tmpFile");
                } catch (SecurityException se) {
                    logger.error("Could not delete temporary file! Please check permissions!", se);
                }
        }
    }


    /**
     * 导入项目信息
     * @param batchUploadLog
     * @param tmpFile
     * @param coreTenantId
     */
    private void updateItem(BatchUploadLogVO batchUploadLog, File tmpFile, Integer coreTenantId) {
        FileReader fr = null;
        BufferedReader bf =null;
        try {
            fr = new FileReader(tmpFile);
            bf = new BufferedReader(fr);
            String line = null;
            String[] lineArr = null;
            long start = 0L;
            long end = 0L;
            String message = "";
            int lineCount = 0;

            switch (batchUploadLog.getFileType()){
                case "ITEM":
                    start = System.currentTimeMillis();
                    List<Item> items = new LinkedList<>();
//                        itemId, itemDescription, itemUrl, itemImageUrl
                    while ((line = bf.readLine()) != null) {
                        lineArr = line.split(",",-1);
                        if(lineArr.length!=4){
                            errorUpdateLog(batchUploadLog,"列不匹配，数据列需要是4，实际值是:"+lineArr.length);
                            return ;
                        }
                        if(lineArr[0]== null || lineArr[0].length()<1){
                            errorUpdateLog(batchUploadLog,"第一列不能为空");
                            return ;
                        }

                        //Integer tenantId,String itemId,String itemType,String description,String url,String imgUrl
                        items.add(new Item(coreTenantId,lineArr[0].trim(),"ITEM",lineArr[1].trim(),
                                lineArr[2].trim(),lineArr[3].trim()));
                    }
                    // 插入到数据库中
                    lineCount = itemDAO.batchAdd(items);

                    if(items.size() != lineCount){
                        message="实际数据有："+items.size()+"条,但是导入了："+lineCount+"条";
                    }else{
                        message="";
                    }
                    end = System.currentTimeMillis();
                    updateLog(batchUploadLog,lineCount,(end-start)*1.0/1000,"成功",message);

                    break;
                case "VIEW":
                case "RATE":
                case "BUY":
                    start = System.currentTimeMillis();
//                    userId, itemId, itemType, itemDescription,
//                            itemUrl, itemImageUrl, rateValue/viewValue/buyValue, actionDate, actionInfo
                    List<UploadRating> actions = new LinkedList<>();
//
                    while ((line = bf.readLine()) != null) {
                        lineArr = line.split(",",-1);
                        if(lineArr.length!=9){
                            errorUpdateLog(batchUploadLog,"列不匹配，数据列需要是9，实际值是:"+lineArr.length);
                            return ;
                        }
                        if(lineArr[1]== null || lineArr[1].length()<1){
                            errorUpdateLog(batchUploadLog,"第二列(ItemId)不能为空");
                            return ;
                        }

                        actions.add(new UploadRating(lineArr[0].trim(),lineArr[1].trim(),
                                lineArr[2].trim(),lineArr[3].trim(),
                                lineArr[4].trim(),lineArr[5].trim(),
                                lineArr[6].trim(),lineArr[7].trim(),lineArr[8].trim()));
                    }
                    // 插入到数据库中

                    insertAction(batchUploadLog, actions,coreTenantId);

                    end = System.currentTimeMillis();
                    if(batchUploadLog.getLineCount() != actions.size()){
                        message = batchUploadLog.getMessage()+"\n"+"数据一共："+actions.size()+",但是导入了："+batchUploadLog.getLineCount();

                        updateLog(batchUploadLog, batchUploadLog.getLineCount(), (end - start) * 1.0 / 1000, "部分成功", message);
                    }else {
                        updateLog(batchUploadLog, batchUploadLog.getLineCount(), (end - start) * 1.0 / 1000, "成功", message);
                    }
                    batchUploadLog.setMessage(batchUploadLog.getMessage().substring(0,300));
                    break;

                default:
                    batchUploadLog.setLineCount(-1);
                    batchUploadLog.setMessage("没有对应到数据类型："+ batchUploadLog.getFileType());
                    batchUploadLog.setStatus("失败");
                    batchUploadLog.setTime(0.0);
            }

        }catch(Exception e){
            e.printStackTrace();
        }finally {
            try {
                bf.close();
                fr.close();
            }catch (Exception e){
                e.printStackTrace();
            }
        }
    }

    private void insertAction(BatchUploadLogVO batchUploadLog, List<UploadRating> actions, Integer coreTenantId) {
        int lineCount =0;
        for(UploadRating UploadRating :actions) {
            Date actionDate = null;
            try {
                if (UploadRating.getActiontime() != null && UploadRating.getActiontime().length() > 5) {
                    SimpleDateFormat dateFormatter = new SimpleDateFormat(dateFormat);
                    actionDate = MyUtils.dateFormatCheck(UploadRating.getActiontime(), dateFormatter);
                } else {
                    actionDate = new Date();
                }
            }catch(Exception e){
                batchUploadLog.setMessage(batchUploadLog.getMessage()+"\n"+"时间转化异常："+UploadRating.getActiontime());
                actionDate = new Date();
            }

            Integer rateValue = -1;
            Integer maxValue =-1;
            Integer minValue =-1;
            try {
                rateValue = Integer.valueOf(UploadRating.getActionvalue());
                maxValue = tenantService.getTenantById(coreTenantId).getRatingRangeMax();
                minValue = tenantService.getTenantById(coreTenantId).getRatingRangeMin();
                if (coreTenantId != null && (rateValue < minValue ||
                        rateValue > maxValue))
                    throw new Exception();
            } catch (Exception e) {
                batchUploadLog.setMessage("UploadRating Value must be a valid Integer in the range from "+minValue+
                        " to "+maxValue+"!");
                continue ;
            }
            RemoteTenant r = remoteTenantDAO.get(coreTenantId);
//            RemoteTenant remoteTenant, String userId, String itemId, String itemType,
//            String itemDescription, String itemUrl, String itemImageUrl, String actionType, Integer actionValue,
//                    Date actionTime, Session session, String actionInfo
            shopRecommenderService.sendAction(r, UploadRating.getUserid(), UploadRating.getItemid(), UploadRating.getItemtype(),
                    UploadRating.getItemdescription(), UploadRating.getItemurl(), UploadRating.getItemimageurl(),
                    batchUploadLog.getFileType(),
                    rateValue, actionDate, session, UploadRating.getActioninfo());
            lineCount ++;
        }
        batchUploadLog.setLineCount(lineCount);

    }

    /**
     * 出错时更新
     * @param batchUploadLog
     * @param msg
     */
    private void errorUpdateLog(BatchUploadLogVO batchUploadLog, String msg) {
        updateLog(batchUploadLog,-1,0.0,"失败",msg);
    }

    /**
     * 出错时更新
     * @param batchUploadLog
     * @param msg
     */
    private void updateLog(BatchUploadLogVO batchUploadLog,Integer lineCount,Double time,String status, String msg) {
        batchUploadLog.setMessage(msg);
        batchUploadLog.setLineCount(lineCount);
        batchUploadLog.setStatus(status);
        batchUploadLog.setTime(time);
    }

    public void setPluginRegistry(PluginRegistry pluginRegistry) {
        this.pluginRegistry = pluginRegistry;
    }

    public void setAppContext(ApplicationContext appContext) {
        this.appContext = appContext;
    }

    public void setBatchUploadLogDAO(BatchUploadLogDAO batchUploadLogDAO) {
        this.batchUploadLogDAO= batchUploadLogDAO;
    }

    public void setOperatorDAO(OperatorDAO operatorDAO) {
        this.operatorDAO = operatorDAO;
    }

    public void setItemDAO(ItemDAO itemDAO) {
        this.itemDAO = itemDAO;
    }

    public void setShopRecommenderService(ShopRecommenderService shopRecommenderService) {
        this.shopRecommenderService = shopRecommenderService;
    }

    public void setTenantService(TenantService tenantService) {
        this.tenantService = tenantService;
    }

    public void setRemoteTenantDAO(RemoteTenantDAO remoteTenantDAO) {
        this.remoteTenantDAO = remoteTenantDAO;
    }
}
