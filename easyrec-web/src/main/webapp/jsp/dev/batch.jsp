<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%--
  ~ Copyright 2010 Research Studios Austria Forschungsgesellschaft mBH
  ~
  ~ This file is part of easyrec.
  ~
  ~ easyrec is free software: you can redistribute it and/or modify
  ~ it under the terms of the GNU General Public License as published by
  ~ the Free Software Foundation, either version 3 of the License, or
  ~ (at your option) any later version.
  ~
  ~ easyrec is distributed in the hope that it will be useful,
  ~ but WITHOUT ANY WARRANTY; without even the implied warranty of
  ~ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  ~ GNU General Public License for more details.
  ~
  ~ You should have received a copy of the GNU General Public License
  ~ along with easyrec.  If not, see <http://www.gnu.org/licenses/>.
  --%>

<div class="appendbody">
    <h1>批量导入</h1>
    <a href="batchupload?tenantId=${tenantId}&operatorId=${operatorId}">导入新数据</a>
    <br/>
    <%--(Integer id,String fileType,String fileName,
                            Integer lineCount,String status,Long time,String message,
                            String tenantId,String operatorId,String token,String apikey--%>
    <table width="100%" cellpadding="10">
        <tr>
            <th>编号</th>
            <th>文件类型</th>
            <th>文件名称</th>
            <th>记录数</th>
            <th>状态</th>
            <th>耗时(s)</th>
            <th>信息</th>
            <th>租户</th>
        </tr>
        <c:forEach var="plugin" items="${logList}" varStatus="status">
            <tr <c:if test="${status.count % 2 == 1}">style="background-color:#eeeeee"</c:if>>
                <td>${plugin.id}</td>
                <td>${plugin.fileType}</td>
                <td>${plugin.fileName}</td>
                <td>${plugin.lineCount}</td>
                <td width="100">
                        ${plugin.status}
                </td>
                <td>${plugin.time}</td>
                <td>${plugin.message}</td>
                <td>${plugin.tenantId}</td>

            </tr>
        </c:forEach>
    </table>
</div>

<script type="text/javascript">
    $(document).ready(function() {
        $(':checkbox').iphoneStyle();
    });
</script>

