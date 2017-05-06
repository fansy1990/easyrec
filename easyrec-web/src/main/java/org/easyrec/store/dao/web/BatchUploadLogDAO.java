/**Copyright 2010 Research Studios Austria Forschungsgesellschaft mBH
 *
 * This file is part of easyrec.
 *
 * easyrec is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * easyrec is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with easyrec.  If not, see <http://www.gnu.org/licenses/>.
 */
package org.easyrec.store.dao.web;

import org.easyrec.model.web.BatchUploadLogVO;

import java.util.List;

/**
 * @author szavrel
 */
public interface BatchUploadLogDAO {

    public static final String DEFAULT_TABLE_NAME = "batchuploadlog";
//    private Integer id;
//
//    private String fileType;
//    private String fileName;
//    private Integer lineCount;
//    private String status;
//    private Long time;
//String tenantId,String operatorId,String token,String apikey
    public static final String DEFAULT_ID_COLUMN_NAME = "id";
    public static final String DEFAULT_FILE_TYPE = "fileType";
    public static final String DEFAULT_FILE_NAME = "fileName";
    public static final String DEFAULT_LINE_COUNT = "lineCount";
    public static final String DEFAULT_STATUS = "status";
    public static final String DEFAULT_TIME = "time";
    public static final String DEFAULT_MESSAGE="message";
    public static final String DEFAULT_TENANT_ID="tenantId";
    public static final String DEFAULT_OPERATOR_ID="operatorId";
    public static final String DEFAULT_TOKEN="token";
    public static final String DEFAULT_APIKEY="apikey";


    public void storeBatchUploadLog(BatchUploadLogVO batchUploadLog);

//    public void deleteBatchUploadLog(Integer id);

//    public PluginVO loadPlugin(URI pluginId, Version version);
//    //    public PluginVO loadPlugin(Integer id);
//
//    public void updatePluginState(URI pluginId, Version version, String state);

    public List<BatchUploadLogVO> loadBatchUploadLogs();
    public List<BatchUploadLogVO> loadBatchUploadLogsByOperator(String operatorId);
//
//    public List<PluginVO> loadPlugins(String state);
//
//    public List<PluginVO> loadPluginInfos();
//
//    public List<PluginVO> loadPluginInfos(String state);
}
