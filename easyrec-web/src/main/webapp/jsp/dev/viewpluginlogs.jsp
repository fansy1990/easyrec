<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="texta" uri="/WEB-INF/tagLib.tld" %>
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

<script src="${webappPath}/js/dev.js" type="text/javascript"></script>
<div class="appendbody">
    <h1>插件日志</h1>
    <p>此页面提供有关插件调度器的信息。
        你可以看到某个时间是哪个租户正在被调度。
        <br/>
        在详情模块，你可以看到运行的配置信息和插件的统计信息。
      </p>
    <c:if test="${tenantId!='' && type==''}">
        <a href="viewpluginlogs?operatorId=${operatorId}&tenantId=${tenantId}&type=all">显示所有日志...</a><br/>

        <p>

            展示'<b>${operatorId}</b>' 操作者和 '<b>${tenant}</b>'租户的插件日志。<br/>
        </p>
    </c:if>
    <c:choose>
        <c:when test="${logCount>0}">
            <div id="remotetenants">
                <c:if test="${type=='all'}">
                    <p>
                        <a id="emptyPluginLogs" href="javascript:emptyPluginLogs('${operatorId}','${tenantId}');">
                            <img title="clear generator logs" alt="delete all plugin logs"
                                 src="${webappPath}/img/button_delete.png"/>
                        </a>
                        删除 <em>所有</em>插件日志
                    </p>
                </c:if>

                <c:if test="${logCount>50}">
                    ${pageMenuString}<br/><br/>
                </c:if>

                <table id="logTable" width="100%">
                    <tr>
                        <th>#</th>
                        <c:if test="${type=='all'}">
                            <th>操作者</th>
                            <th>租户</th>
                        </c:if>
                        <th>关联类型</th>
                        <th>插件</th>
                        <th>执行日期</th>
                        <th>持续时间</th>
                        <th>详情</th>
                        <th>状态</th>
                        <th>管理</th>
                    </tr>
                    <c:forEach var="logEntry" items="${logEntries}" varStatus="status">
                        <tr id="${logEntry.id}"
                            <c:if test="${status.count % 2 == 1}">style="background-color:#eeeeee"</c:if>>
                            <td align="right">${logEntry.id}</td>
                            <c:if test="${type=='all'}">
                                <td>${logEntry.operator}</td>
                                <td>
                                    <a title="view logs for ${logEntry.tenant}"
                                       href="viewpluginlogs?tenantId=${logEntry.tenantId}&operatorId=${logEntry.operator}">
                                        <texta:stringabbreviator myString="${logEntry.tenant}" maxLength="20"/>
                                    </a>
                                </td>
                            </c:if>
                            <td>${logEntry.assocType}</td>
                            <td>
                                <texta:stringabbreviator myString="${logEntry.pluginId}" maxLength="50" 
                                                         reversed="true"/>
                            </td>
                            <td align="right">
                                <fmt:formatDate value="${logEntry.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </td>
                            <td align="right">${logEntry.durationString}</td>
                            <td>
                                <a title="Show configuration and statistics for this run."
                                   onclick="$('#details-${logEntry.id}').dialog({ width: 460 })"
                                   href="javascript:void(0);">Details&hellip;</a>

                                <div id="details-${logEntry.id}" style="display: none;max-height: 500px;"
                                     title="Details for log entry #${logEntry.id}">
                                    <strong>Configuration</strong>
                                    <pre style="overflow:scroll">${fn:replace(fn:replace(logEntry.configuration.xmlRepresentation, "<", "&lt;"),"\"", "&quot;")}</pre>
                                    <strong>Statistics</strong>
                                    <pre style="overflow:scroll">${fn:replace(fn:replace(logEntry.statistics.xmlRepresentation, "<", "&lt;"), "\"", "&quot;")}</pre>
                                </div>
                            </td>
                            <td align="center">
                                <c:if test="${logEntry.status=='RUNNING'}">
                                    <img title="running &hellip;" alt="running &hellip;"
                                         src="${webappPath}/img/wait16.gif"/>
                                </c:if>
                                <c:if test="${logEntry.status=='FINISHED'}">
                                    <img title="done" alt="done" style="padding-right: 10px;"
                                         src="${webappPath}/img/button_check.png"/>
                                </c:if>
                                <c:if test="${logEntry.status=='ABORTED'}">
                                    <img title="aborted" alt="aborted" style="padding-right: 10px;"
                                         src="${webappPath}/img/icon_warning.png"/>
                                </c:if>
                            </td>
                            <td align="center">
                                <a href="viewpluginconfig?operatorId=${logEntry.operator}&tenantId=${logEntry.tenant}">
                                    <img title="configure ${logEntry.tenant}" alt="config tenant" src="${webappPath}/img/button_settings.png"/>
                                </a>
                                <a href="${webappPath}/tenant/statistics?tenantId=${logEntry.tenant}&operatorId=${logEntry.operator}">
                                    <img title="show ${logEntry.tenant}'s statistics" alt="statistics" src="${webappPath}/img/button_statistics.png"/>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
                <br/>
                <c:if test="${logCount>50}">
                    ${pageMenuString}<br/>
                </c:if>
            </div>
        </c:when>
        <c:otherwise>
            <p>迄今为止还没有插件日志。
               您可以在<a href="viewalltenants">租户模块</a>检查租户配置信息，从而为每个租户安排插件。
            </p>
        </c:otherwise>
    </c:choose>
</div>