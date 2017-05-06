/*
 * Copyright 2010 Research Studios Austria Forschungsgesellschaft mBH
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
package org.easyrec.store.dao.web.impl;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.easyrec.model.web.BatchUploadLogVO;
import org.easyrec.store.dao.web.BatchUploadLogDAO;
import org.easyrec.utils.spring.store.dao.DaoUtils;
import org.easyrec.utils.spring.store.dao.annotation.DAO;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.support.AbstractLobCreatingPreparedStatementCallback;
import org.springframework.jdbc.core.support.JdbcDaoSupport;
import org.springframework.jdbc.support.lob.DefaultLobHandler;
import org.springframework.jdbc.support.lob.LobCreator;

import javax.sql.DataSource;
import java.sql.*;
import java.util.List;

/**
 * @author szavrel
 */
@DAO
public class BatchUploadLogDAOMysqlImpl extends JdbcDaoSupport implements BatchUploadLogDAO {

    private final Log logger = LogFactory.getLog(this.getClass());
    private DefaultLobHandler lobHandler;
    private BatchUploadLogRowMapper rowMapper = new BatchUploadLogRowMapper();

    private static final String SQL_ADD_BATCHUPLOADLOG;
//    private static final String SQL_UPDATE_PLUGIN;
//    private static final String SQL_LOAD_PLUGIN;
    private static final String SQL_LOAD_BATCHUPLOADLOGS;
    private static final String SQL_LOAD_BATCHUPLOADLOGS_BY_OPERATORID;
//    private static final String SQL_UPDATE_PLUGIN_STATE;
//    private static final String SQL_DELETE_PLUGIN;

    static {
//        private Integer id;
//
//        private String fileType;
//        private String fileName;
//        private Integer lineCount;
//        private String status;
//        private Long time;
//        String tenantId,String operatorId,String token,String apikey
        SQL_ADD_BATCHUPLOADLOG = new StringBuilder().append("INSERT INTO ").append(DEFAULT_TABLE_NAME).append(" (")
                .append(DEFAULT_FILE_TYPE).append(",").append(DEFAULT_FILE_NAME).append(",")
                .append(DEFAULT_LINE_COUNT).append(",").append(DEFAULT_STATUS).append(",")
                .append(DEFAULT_TIME).append(",").append(DEFAULT_MESSAGE).append(",")
                .append(DEFAULT_TENANT_ID).append(",").append(DEFAULT_OPERATOR_ID).append(",")
                .append(DEFAULT_TOKEN).append(",").append(DEFAULT_APIKEY)
                .append(") ").append("VALUES (?,?,?,?,?,?,?,?,?,?)").toString();

        SQL_LOAD_BATCHUPLOADLOGS = new StringBuilder().append(" SELECT * FROM ").append(DEFAULT_TABLE_NAME).toString();

        SQL_LOAD_BATCHUPLOADLOGS_BY_OPERATORID = new StringBuilder().append(" SELECT * FROM ")
                .append(DEFAULT_TABLE_NAME).append(" WHERE ")
                .append(DEFAULT_OPERATOR_ID).append(" = ?").toString();

    }

    public BatchUploadLogDAOMysqlImpl(DataSource dataSource) {
        setDataSource(dataSource);
        lobHandler = new DefaultLobHandler();
    }

    @Override
    public void storeBatchUploadLog(final BatchUploadLogVO batchUploadLog) {

        final BatchUploadLogVO batchUploadLogParam = batchUploadLog;
        try {

            getJdbcTemplate().execute(SQL_ADD_BATCHUPLOADLOG, new AbstractLobCreatingPreparedStatementCallback(lobHandler) {

                @Override
                protected void setValues(PreparedStatement ps, LobCreator lobCreator)
                        throws SQLException, DataAccessException {
                    ps.setString(1, batchUploadLogParam.getFileType());
                    ps.setString(2, batchUploadLogParam.getFileName());
                    ps.setString(3, batchUploadLogParam.getLineCount().toString());
                    ps.setString(4, batchUploadLogParam.getStatus());
                    ps.setString(5, batchUploadLogParam.getTime().toString());
                    ps.setString(6,batchUploadLogParam.getMessage());
                    ps.setString(7,batchUploadLogParam.getTenantId());
                    ps.setString(8,batchUploadLogParam.getOperatorId());
                    ps.setString(9,batchUploadLogParam.getToken());
                    ps.setString(10,batchUploadLogParam.getApikey());

                }
            });

        } catch (DataIntegrityViolationException e) {

            logger.error("An error occured storing the batchUploadLog! " + e);
        }
    }



    public List<BatchUploadLogVO> loadBatchUploadLogs() {
        try {
            return getJdbcTemplate().query(SQL_LOAD_BATCHUPLOADLOGS, rowMapper);
        } catch (Exception e) {
            logger.error("An error occured loading all batch upload logs ! " + e);
        }
        return null;
    }

    @Override
    public List<BatchUploadLogVO> loadBatchUploadLogsByOperator(String operatorId) {
        try {
            Object[] args = {operatorId};
            int[] argTypes = {Types.VARCHAR};
            return getJdbcTemplate().query(SQL_LOAD_BATCHUPLOADLOGS_BY_OPERATORID, args,argTypes,rowMapper);
        } catch (Exception e) {
            logger.error("An error occured loading all batch upload logs ! " + e);
        }
        return null;
    }

    private class BatchUploadLogRowMapper implements RowMapper<BatchUploadLogVO>{

        @Override
        public BatchUploadLogVO mapRow(ResultSet rs, int i) throws SQLException {
            return new BatchUploadLogVO(DaoUtils.getIntegerIfPresent(rs, DEFAULT_ID_COLUMN_NAME),
                    DaoUtils.getStringIfPresent(rs, DEFAULT_FILE_TYPE),
                    DaoUtils.getStringIfPresent(rs, DEFAULT_FILE_NAME),
                    DaoUtils.getIntegerIfPresent(rs, DEFAULT_LINE_COUNT),
                    DaoUtils.getStringIfPresent(rs, DEFAULT_STATUS),
                    DaoUtils.getDoubleIfPresent(rs, DEFAULT_TIME),
                    DaoUtils.getStringIfPresent(rs, DEFAULT_MESSAGE),
                    DaoUtils.getStringIfPresent(rs, DEFAULT_TENANT_ID),
                    DaoUtils.getStringIfPresent(rs, DEFAULT_OPERATOR_ID),
                    DaoUtils.getStringIfPresent(rs, DEFAULT_TOKEN),
                    DaoUtils.getStringIfPresent(rs, DEFAULT_APIKEY));
        }
    }

}
