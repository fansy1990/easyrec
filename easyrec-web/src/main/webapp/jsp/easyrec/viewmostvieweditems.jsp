<%@ taglib prefix="texta" uri="/WEB-INF/tagLib.tld" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>
<%@ taglib prefix="esapi" uri="/WEB-INF/esapi.tld" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8"%>

<script src="${webappPath}/js/easyrec.js" type="text/javascript"></script>
<script src="${webappPath}/js/item.js" type="text/javascript"></script>

<div class="appendbody">

    <jsp:include page="menu.jsp"/>

    <jsp:include page="menubar.jsp"/>

    <h2> "${tenantId}" 的Top排序</h2>

    <p>
        Top排序显示了在所选时间范围内有最多相关行为的项目。<br/>
    </p>

    <p>
        <b>注意:</b>这个排行每24小时更新一次。<br/><br/>
    </p>

    展示&nbsp;
    <select id="assoc" name="assoc" onchange="changeView('${operatorId}','${tenantId}')">
        <option
                <c:if test="${param.assoc=='mostviewed'}">selected="selected"</c:if>
                value="mostviewed">查看最多的项目
        </option>
        <option
                <c:if test="${param.assoc=='mostbought'}">selected="selected"</c:if>
                value="mostbought">购买最多的项目
        </option>
        <option
                <c:if test="${param.assoc=='mostrated'}">selected="selected"</c:if>
                value="mostrated">评价最多的项目
        </option>
        <option
                <c:if test="${param.assoc=='bestrated'}">selected="selected"</c:if>
                value="bestrated">评价最高的项目
        </option>
        <option
                <c:if test="${param.assoc=='worstrated'}">selected="selected"</c:if>
                value="worstrated">评价最差的项目
        </option>
    </select>&nbsp;from&nbsp;
    <select id="timerange" name="time" onchange="changeView('${operatorId}','${tenantId}')">
        <option
                <c:if test="${param.timerange=='MONTH'}">selected="selected"</c:if>
                value="MONTH">最后31天
        </option>
        <option
                <c:if test="${param.timerange=='WEEK'}">selected="selected"</c:if> value="WEEK">
            最后7天
        </option>
        <option
                <c:if test="${param.timerange=='DAY'}">selected="selected"</c:if> value="DAY">
            最后24小时
        </option>
        <option
                <c:if test="${param.timerange=='ALL'}">selected="selected"</c:if> value="ALL">
            全部时间
        </option>
    </select>
    <img id="redirect" alt="wait" src="${webappPath}/img/blank.gif"/>
    <hr/>
    <div class="contentContainer">
        <display:table name="items" class="tableData" id="row"
                       requestURI="${webappPath}/tenant/viewmostvieweditems?tenantId=${tenantId}&operatorId=${operatorId}"
                       pagesize="0">
            <display:column title="编号">
                ${esapi:encodeForHTML(row.itemId)}
            </display:column>
            <display:column title="描述">
                <a href="javascript:void(0);"
                   onclick="loadItem('${operatorId}','${tenantId}','${row.id}','${esapi:encodeForJavaScript(row.description)}', true);">
                        ${esapi:encodeForHTML(row.description)}
                </a>
            </display:column>
            <display:column title="类型">
                ${esapi:encodeForHTML(row.itemType)}
            </display:column>
            <display:column style="width:20px;">
                <a href="${esapi:encodeForHTMLAttribute(row.url)}" target="_blank">
                    <img title="open this item in new tab" src="${webappPath}/img/button_globe.png"/>
                </a>
            </display:column>
        </display:table>
    </div>
</div>