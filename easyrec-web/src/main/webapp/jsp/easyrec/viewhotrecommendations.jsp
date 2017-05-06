<%@ taglib prefix="texta" uri="/WEB-INF/tagLib.tld" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>
<%@ taglib prefix="esapi" uri="/WEB-INF/esapi.tld" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8"%>


<%--@elvariable id="tenantId" type="java.lang.String"--%>
<%--@elvariable id="items" type="java.util.List<org.easyrec.model.core.web.Item>"--%>

<script src="${webappPath}/js/easyrec.js" type="text/javascript"></script>
<script src="${webappPath}/js/item.js" type="text/javascript"></script>

<div class="appendbody">
    <jsp:include page="menu.jsp"/>

    <jsp:include page="menubar.jsp"/>
    <span class="headlineBig">
        "${tenantId}"上的热点推荐
    </span>

    <p>热门推荐列表显示了最受欢迎的推荐项目，即华联云谷推荐平台呈现给用户的推荐也被用户所点击。



    </p>

    <div class="contentContainer">
        <display:table name="items" class="tableData" id="row"
                       requestURI="${webappPath}/tenant/viewmostvieweditems?tenantId=${tenantId}&operatorId=${operatorId}"
                       pagesize="0">
            <display:column title="id">
                ${esapi:encodeForHTML(row.itemId)}
            </display:column>
            <display:column title="Description">
                <a href="javascript:void(0);"
                   onclick="loadItem('${operatorId}','${tenantId}','${row.id}','${esapi:encodeForJavaScript(row.description)}', true);">
                        ${esapi:encodeForHTML(row.description)}
                </a>

                (${fn:substringBefore(row.value,".")} recommendation hits)
            </display:column>
            <display:column title="Type">
                ${esapi:encodeForHTML(row.itemType)}
            </display:column>
            <display:column style="width:20px;">
                <a href="${esapi:encodeForHTMLAttribute(row.url)}" target="_blank">
                    <img title="open this item in new tab" src="${webappPath}/img/button_globe.png"/>
                </a>
            </display:column>
        </display:table>

        <c:if test="${fn:length(items)==0}">
            <p>注意：此功能仅适用于在REST API提供的推荐内容中，使用华联云谷推荐平台提供的URL。
                否则华联云谷无法跟踪推荐项目的点击，并且您丢失了有价值的信息。
            </p>
        </c:if>

    </div>
</div>

