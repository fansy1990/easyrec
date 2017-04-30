<%@ page language="java" session="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="esapi" uri="/WEB-INF/esapi.tld" %>
<%@ taglib prefix="easyrec" uri="/WEB-INF/tagLib.tld" %>
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

<%--@elvariable id="webappPath" type="java.lang.String"--%>
<%--@elvariable id="detailBoxUniqueId" type="java.lang.String"--%>
<%--@elvariable id="editEnabled" type="boolean"--%>
<%--@elvariable id="operatorId" type="java.lang.String"--%>
<%--@elvariable id="tenantId" type="java.lang.String"--%>
<%--@elvariable id="tenant" type="org.easyrec.model.core.web.RemoteTenant"--%>
<%--@elvariable id="item" type="org.easyrec.model.core.web.Item"--%>
<%--@elvariable id="clusters" type="java.util.List<org.easyrec.model.core.ClusterVO>"--%>

<div id="itemTabs${detailBoxUniqueId}" class="itemDetailTabContainer">
    <ul>
        <c:if test="${editEnabled}">
            <li><a href="#editItem${detailBoxUniqueId}"><span>编辑</span></a></li>
        </c:if>
        <li><a href="#viewItem${detailBoxUniqueId}"><span>详情</span></a></li>
        <li>
            <a href="${webappPath}/tenant/rulestoitem?operatorId=${operatorId}&tenantId=${tenantId}&itemId=${item.id}"><span>规则</span></a>
        </li>
        <li>
            <a href="${webappPath}/item/viewitemstatistics?operatorId=${operatorId}&tenantId=${tenantId}&itemId=${item.id}"><span>统计</span></a>
        </li>
    </ul>

    <c:if test="${editEnabled}">
        <div id="editItem${detailBoxUniqueId}">
            <div style="height:165px;">
                <div>项目的url可以是相对或者是绝对的。如果你想使用绝对url，那么url需要以
                     <strong>"http://"</strong> 或者 <strong>"https://"</strong> 作为开头。
                    如果你正在使用一个相对路径，那么它就需要和当前的租户url
                    <a href="${tenant.url}" target="_blank">${tenant.url}</a>联系在一起。
                    如果租户路径是项目路径的一部分，那么就只会显示相对路径。
                </div>
                <div class="success" style="display:none;">

                </div>
            </div>

            <label for="editItemDescription${item.id}">描述</label>
            <input id="editItemDescription${item.id}" name="editItemDescription${item.id}" type="text"
                   value="${esapi:encodeForHTMLAttribute(item.description)}"/>

            <label for="editItemUrl${item.id}">项目url</label>
            <input id="editItemUrl${item.id}" name="editItemUrl${item.id}" type="text"
                   value="${esapi:encodeForHTMLAttribute(item.relativeUrl)}"/>

            <label for="editItemImageUrl${item.id}">项目的图片url</label>
            <input id="editItemImageUrl${item.id}" name="editItemImageUrl${item.id}" type="text"
                   value="${esapi:encodeForHTMLAttribute(item.relativeImageUrl)}"/>

            <a style="float:right;" href="javascript:void(0);"
               onclick="saveItem('${operatorId}','${tenantId}','${item.id}', '${tenant.url}','${detailBoxUniqueId}')">
                <img src="${webappPath}/img/button_save.png" alt="save"/>
            </a>
        </div>
    </c:if>

    <div id="viewItem${detailBoxUniqueId}">
        <div class="itemDetailImage">
            <img id="image${item.id}" src="${esapi:encodeForHTMLAttribute(item.imageUrl)}" alt="detail image for the item">
        </div>

        <p style="height:120px;">
            这里您可以发现所选项目的一些详细信息。
            使用编辑选项可以来修改这些值。
        </p>

        <dl>
            <dt>ID:</dt>
            <dd>${esapi:encodeForHTML(item.itemId)}</dd>

            <dt>类型:</dt>
            <dd>${item.itemType}</dd>

            <dt>描述:</dt>
            <dd id="itemDescription${item.id}">${esapi:encodeForHTML(item.description)}</dd>

            <dt>创建日期:</dt>
            <dd>${item.creationDate}</dd>

            <dt>URL:</dt>
            <dd id="itemUrl${item.id}">
                <a href="${esapi:encodeForHTMLAttribute(item.url)}" target="_blank">
                    ${esapi:encodeForHTML(item.url)}
                </a>
            </dd>

            <dt>图片 URL:</dt>
            <dd id="itemImageUrl${item.id}">
                <a href="${esapi:encodeForHTMLAttribute(item.imageUrl)}" target="_blank">
                    ${esapi:encodeForHTML(item.imageUrl)}
                </a>
            </dd>

            <dt>激活:</dt>
            <dd id="itemActive">${item.active}</dd>

            <dt>分组:</dt>
            <dd id="itemClusters">
                <c:choose>
                    <c:when test="${clusters == null || fn:length(clusters) == 0}">
                        None
                    </c:when>
                    <c:otherwise>
                        <ul style="display:inline">
                            <c:forEach items="${clusters}" var="cluster">
                                <li><span title="${cluster.description}">${cluster.name}</span></li>
                            </c:forEach>
                        </ul>
                    </c:otherwise>
                </c:choose>
            </dd>
        </dl>

        <c:if test="${profile != null}">
            <h1>配置</h1>
            <easyrec:profileRenderer profile="${profile}"/>
        </c:if>

    </div>

</div>
