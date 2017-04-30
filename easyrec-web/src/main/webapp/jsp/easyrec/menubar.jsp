<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8"%>

<h1>${tenantId}</h1>

<c:choose>
    <c:when test="${menubar=='tenant'}">
        <span class="bullmenu">概述</span>&nbsp;&bull;
    </c:when>
    <c:otherwise>
        <a href="${webappPath}/easyrec/overview?menu=x&tenantId=${tenantId}&operatorId=${operatorId}">概述</a>&nbsp;&bull;
    </c:otherwise>
</c:choose>

<c:choose>
    <c:when test="${menubar=='viewItems'}">
        <span class="bullmenu"> 项目 &amp; 规则 </span>&nbsp;&bull;
    </c:when>
    <c:otherwise>
        <a href="${webappPath}/tenant/items?tenantId=${tenantId}&operatorId=${operatorId}"> 项目 &amp; 规则 </a>&nbsp;&bull;
    </c:otherwise>
</c:choose>

<c:choose>
    <c:when test="${menubar=='viewStatistics'}">
        <span class="bullmenu"> 统计 </span>&nbsp;&bull;
    </c:when>
    <c:otherwise>
        <a href="${webappPath}/tenant/statistics?tenantId=${tenantId}&operatorId=${operatorId}"> 统计 </a>&nbsp;&bull;
    </c:otherwise>
</c:choose>

<c:choose>
    <c:when test="${menubar=='viewMostViewedItems'}">
        <span class="bullmenu"> Top排序 </span>&nbsp;&bull;
    </c:when>
    <c:otherwise>
        <a href="${webappPath}/tenant/viewmostvieweditems?tenantId=${tenantId}&operatorId=${operatorId}"> Top排序 </a>&nbsp;&bull;
    </c:otherwise>
</c:choose>

<c:choose>
    <c:when test="${menubar=='viewHotRecommendations'}">
        <span class="bullmenu"> 热点推荐 </span> &nbsp;&bull;
    </c:when>
    <c:otherwise>
        <a href="${webappPath}/tenant/viewhotrecommendations?tenantId=${tenantId}&operatorId=${operatorId}"> 热点推荐
        </a>  &nbsp;&bull;
    </c:otherwise>
</c:choose>

<c:choose>
    <c:when test="${menubar=='clustermanager'}">
        <span class="bullmenu"> 分组管理 </span> &nbsp;&bull;
    </c:when>
    <c:otherwise>
        <a href="${webappPath}/tenant/clustermanager?tenantId=${tenantId}&operatorId=${operatorId}"> 分组管理 </a> &nbsp;&bull;
    </c:otherwise>
</c:choose>

<c:choose>
    <c:when test="${menubar=='itemtypes'}">
        <span class="bullmenu"> 类型管理器 </span>
    </c:when>
    <c:otherwise>
        <a href="${webappPath}/tenant/typemanager?tenantId=${tenantId}&operatorId=${operatorId}"> 类型管理器 </a>
    </c:otherwise>
</c:choose>

<br/><br/>