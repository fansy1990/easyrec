<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="easyrec" uri="/WEB-INF/tagLib.tld" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%--
  ~ Copyright 2011 Research Studios Austria Forschungsgesellschaft mBH
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

<script language="javascript" type="text/javascript" src="${webappPath}/js/jquery/jquery.flot.js"></script>
<!--[if IE]><script language="javascript" type="text/javascript" src="${webappPath}/js/jquery/excanvas.min.js"></script><![endif]-->


<span class="headlineBig">租户管理</span><br/>

<p>
    这个图表显示了所选租户每天的用户行为数。使用下拉菜单可以选择图表的时间段
    。 想要了解你的租户的更多数据信息，可以通过点击上方“统计”菜单查看。
     <a href="javascript:followingSteps('${tenant.stringId}')">集成信息</a> 框把所有你需要的东西捆绑在一起，进而把easyrec集成到你的网站中。
</p>

<c:if test="${displayingDefaultTenant}">
    <div class="info">
        <b>注意:</b> 这是为你自动生成的沙箱租户。 使用这个租户你可以试玩easyrec。一旦你理解了easyrec的基本原理， 你可以创建自己的租户并将其整合到你的网站.
        你可以使用下面的链接在你的沙箱租户中产生行为：

        <a href="javascript:simulateViewAction()">产生查看行为</a> |
        <a href="javascript:simulateBuyAction()">产生购买行为</a> |
        <a href="javascript:simulateRateAction()">产生评分行为</a>.

        <a href="https://sourceforge.net/p/easyrec/wiki/get_started/" target="_blank"> 入门指南</a> 为你提供了如何设置租户的大致概述。

    </div>
</c:if>

<dl>
    <dt>租户ID:</dt>
    <dd>${tenant.stringId}</dd>

    <dt>创建日期:</dt>
    <dd> ${tenant.creationDate}</dd>

    <dt>租户网站:</dt>
    <dd><a target="_blank" href="${tenant.url}">${tenant.url}</a></dd>
</dl>

<h3>描述</h3>
<c:if test="${tenant.description!=''}">
    <p style="overflow:auto;width:700px">${tenant.description}</p>
</c:if>


<br>
展示
<select
        id="actionType"
        name="actionType"
        onchange="javascript:updateTenantFlot(${tenant.id})">
    <option value="">所有行为</option>
    <option value="VIEW">查看行为</option>
    <option value="BUY">购买行为</option>
    <option value="RATE">评分行为</option>
    <option value="CLICKS_ON_RECS">点击推荐</option>
    <option value="CLICKS_ON_CHARTS">点击排序</option>
</select>
in
<select
        id="month"
        name="month"
        onchange="javascript:updateTenantFlot(${tenant.id})">
    <option
            <c:if test="${currentMonthName=='January'}">selected="selected"</c:if> value="0">一月
    </option>
    <option
            <c:if test="${currentMonthName=='February'}">selected="selected"</c:if> value="1">
        二月
    </option>
    <option
            <c:if test="${currentMonthName=='March'}">selected="selected"</c:if> value="2">三月
    </option>
    <option
            <c:if test="${currentMonthName=='April'}">selected="selected"</c:if> value="3">四月
    </option>
    <option
            <c:if test="${currentMonthName=='May'}">selected="selected"</c:if> value="4">五月
    </option>
    <option
            <c:if test="${currentMonthName=='June'}">selected="selected"</c:if> value="5">六月
    </option>
    <option
            <c:if test="${currentMonthName=='July'}">selected="selected"</c:if> value="6">七月
    </option>
    <option
            <c:if test="${currentMonthName=='August'}">selected="selected"</c:if> value="7">八月
    </option>
    <option
            <c:if test="${currentMonthName=='September'}">selected="selected"</c:if> value="8">
        九月
    </option>
    <option
            <c:if test="${currentMonthName=='October'}">selected="selected"</c:if> value="9">十月
    </option>
    <option
            <c:if test="${currentMonthName=='November'}">selected="selected"</c:if> value="10">
        十一月
    </option>
    <option
            <c:if test="${currentMonthName=='December'}">selected="selected"</c:if> value="11">
        十二月
    </option>
</select>
<select
        id="year"
        name="year"
        onchange="javascript:updateTenantFlot(${tenant.id})">
    <option value="${currentYear}">${currentYear}</option>
    <option value="${currentYear-1}">${currentYear-1}</option>
    <option value="${currentYear-2}">${currentYear-2}</option>
    <option value="${currentYear-3}">${currentYear-3}</option>
    <option value="${currentYear-4}">${currentYear-4}</option>
</select>
<img id="updateflotwait" alt="wait" src="${webappPath}/img/blank.gif"/>

<!-- begin flot chart -->
<table>
    <tr>
        <td id="legend_actions" colspan="2"
            style="font-size:11px;font-family:sans-serif;color:#666666;display: none;"><br/>#actions
        </td>
    </tr>
    <tr>
        <td colspan="2" style="font-size:11px;font-family:sans-serif;color:#666666" valign="bottom">
            <div id="placeholder${tenant.id}" style="width:670px;height:200px;"></div>
        </td>
        <td id="legend_days" colspan="2"
            style="font-size:11px;font-family:sans-serif;color:#666666;display: none;" valign="bottom">days
        </td>
    </tr>
    <!-- end flot chart -->
    <tr>
        <td style="height: 20px">&nbsp;</td>
    </tr>
</table>

<div id="legendContainer">

</div>

<script type="text/javascript">
    $(function () {
        updateTenantFlot(${tenant.id});
    });

    <c:if test="${displayingDefaultTenant}">
        function simulateViewAction() {

            $.ajax({
                url:webappPath +
                        "api/1.0/view?apikey=${apiKey}&tenantid=EASYREC_DEMO&itemid=42&itemdescription=Fatboy Slim - The Rockafeller Skank&itemurl=/item/fatboyslim&itemimageurl=${extendedWebappPath}/img/covers/fatboyslim.jpg&userid=B&sessionid=b",
                cache: false,
                success: function() {
                    window.location.reload();
                }
            });
        }

        function simulateBuyAction() {
            $.ajax({
                url:webappPath +
                        "api/1.0/buy?apikey=${apiKey}&tenantid=EASYREC_DEMO&itemid=43&itemdescription=Beastie Boys - Intergalactic&itemurl=/item/fatboyslim&itemimageurl=${extendedWebappPath}/img/covers/beastieboys.jpg&userid=B&sessionid=b",
                cache: false,
                success: function() {
                    window.location.reload();
                }
            });
        }

        function simulateRateAction() {
            $.ajax({
                url:webappPath +
                        "api/1.0/rate?apikey=${apiKey}&tenantid=EASYREC_DEMO&itemid=44&itemdescription=Gorillaz - Clint Eastwood&itemurl=/item/fatboyslim&itemimageurl=${extendedWebappPath}/img/covers/gorillaz.jpg&userid=B&sessionid=b&ratingvalue=10",
                cache: false,
                success: function() {
                    window.location.reload();
                }
            });
        }
        <c:if test="${tenant.maxActionLimitAlmostExceeded && !tenant.maxActionLimitExceeded}">
        popup(limitAlmostExceeded);
        </c:if>
        <c:if test="${tenant.maxActionLimitExceeded}">
        popup(limitExceeded);
        </c:if>
    </c:if>

</script>


<div id="followingSteps" style="display:none;">
     <jsp:include page="followingsteps.jsp"/>
</div>