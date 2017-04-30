<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<div class="appendbody">
    <h1>信息</h1>
    <br/>
    <table>
        <tr>
            <td><b>${easyrecName}</b></td>
            <td>${easyrecVersion}</td>
        </tr>
        <tr>
            <td><b>操作者</b></td>
            <td>${signedinOperatorId}</td>
        </tr>
        <tr>
            <td><b>操作模式</b></td>
            <td>${operationMode}</td>
        </tr>
        <tr>
            <td><br/></td>
        </tr>
        <tr>
            <td><b>Webapp-路径</b></td>
            <td>'${webappPath}'</td>
        </tr>
        <tr>
            <td><b>扩展 Webapp-路径</b></td>
            <td>'${extendedWebappPath}'</td>
        </tr>
        <tr>
            <td><br/></td>
        </tr>
        <tr>
            <td><b>数据库名称</b></td>
            <td>'${dbName}'</td>
        </tr>
        <tr>
            <td><b>数据库用户</b></td>
            <td>'${dbUserName}'</td>
        </tr>
        <tr>
            <td><br/><b>已用存储/堆积</b><br/>(每秒刷新一次)</td>
            <td id="usedmem">${usedmemory} MB/${heapsize} MB (<fmt:formatNumber value="${(usedmemory/heapsize)*100}"
                                                                                maxFractionDigits="2"/>% used)
            </td>
        </tr>
        <c:if test="${freespace!=null}">
            <tr>
                <td><b>免费光盘空间</b></td>
                <td>${freespace} GB</td>
            </tr>
        </c:if>
        <tr>
            <td><b>每日插件总数 <br/>计算时间</b></td>
            <td>${dailyComputationTime}</td>
        </tr>


        <tr>
            <td>
                <br/>
                ${operatorCount} <a href="viewoperators">操作者</a>
                ${tenantCount} <a href="viewalltenants">租户</a>
            </td>
        </tr>


    </table>
</div>
<script type="text/javascript">
    $(function()
    {
        pullusedmem(${heapsize}, 0);
    });
</script>
