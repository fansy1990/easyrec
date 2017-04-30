<%@ taglib prefix="texta" uri="/WEB-INF/tagLib.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

<script language="javascript" type="text/javascript" src="${webappPath}/js/jquery/jquery.visualize.js"></script>
<script language="javascript" type="text/javascript" src="${webappPath}/js/enhance.js"></script>
<script language="javascript" type="text/javascript" src="${webappPath}/js/easyrec.js"></script>
<!--[if IE]><script language="javascript" type="text/javascript" src="${webappPath}/js/jquery/excanvas.min.js"></script><![endif]-->

<div class="appendbody">
<jsp:include page="menu.jsp"/>
<table>
<tr>
<td>
<jsp:include page="menubar.jsp"/>
<span class="headlineBig">"${tenantId}"的统计情况</span>

<p>下表显示了所选租户的活动情况
    <br/><b>注意: </b>
    在每一个规则生成器正常执行一天之后，此处显示的数据将会自动更新，所以这里的数据可能会有一点延迟。
    <br/>
    <span id="tenantrefreshstatistics">如果您想看到实时数据，您可以 <a href="javascript:void(0);"
                                                onclick="refreshStatistics('${remoteTenant.stringId}', '${remoteTenant.operatorId}')">立即更新统计数据</a>.</span>
</p>
<table class="stat">
<tr>
    <td><span class="headline">概述</span>
        <hr/>
    </td>
</tr>
<tr>
    <td>
        <table width="100%">
            <tr style="background-color:#efefef;">
                <td width="68%">
                    点击推荐的次数(<span class="conversions">转化率</span>)
                </td>
                <td align="right">
                    ${tenantStatistics.backtracks} (<span
                        class="conversions">${conversionStatistics.recommendationToBuyCount}</span>)
                </td>
                <td width="25px" align="right" style="padding-right: 2px">
                    <img class="clickable" alt="help" src="${webappPath}/img/button_help.png"
                         onclick="$('#div_conversion_help').slideToggle('slow')"/>
                </td>
            </tr>
            <tr class="help">
                <td colspan="3">
                    <div id="div_conversion_help" style="display: none">
                       如果用户购买了之前在推荐中点击的物品，
                        <br/>
                        那么用户点击推荐的行为会被easyrec记录下来，
                        <br/>
                        此时 <span class="conversions">转化率</span> 便提升了。 <br/>
                        这些指标显示出easyrec对于增加您的销售额以及延长您的顾客的访问时间的直接影响。<br/>

                        <hr/>
                    </div>
                </td>
            </tr>
            <tr>
                <td>总行为数 (这个月)</td>
                <td align="right">${tenantStatistics.actions} (${remoteTenant.monthlyActions})</td>
                <td width="25px" align="right" style="padding-right: 2px">
                    <img class="clickable" alt="help" src="${webappPath}/img/button_help.png"
                         onclick="$('#div_monthly_help').slideToggle('slow')"/>
                </td>
            </tr>
            <tr class="help">
                <td colspan="3">
                    <div id="div_monthly_help" style="display: none">
                        这些值显示了总行为数
                     (查看, 购买 &amp; 评分) <br/>
                       以及当前租户本月的行为数。<br/>
                        时间超过
                        <c:if test="${remoteTenant.autoArchiverTimeRange%365>0}">
                            <fmt:formatNumber value="${remoteTenant.autoArchiverTimeRange/365 }" maxFractionDigits="2"/>
                        </c:if>
                        <c:if test="${remoteTenant.autoArchiverTimeRange%365==0}">
                            <fmt:formatNumber value="${remoteTenant.autoArchiverTimeRange/365 }" maxFractionDigits="0"/>
                        </c:if>
                        年的行为将会被认为是过时的，并且会被进行行为存档。<br/>
                        插件将会使用档案库中的行为进行分析并在推荐时进行使用。<br/>
                        <hr/>
                    </div>
                </td>
            </tr>
            <tr style="background-color:#efefef;">
                <td>每月被允许的最大行为数</td>
                <td align="right">
                    <c:if test="${remoteTenant.maxActions>0}">
                        ${remoteTenant.maxActions}
                    (${remoteTenant.limitReachedBy}% reached)
                </td>
                </c:if>
                <c:if test="${remoteTenant.maxActions==0}">无限的</c:if>
                <td width="25px" align="right" style="padding-right: 2px">
                    <img class="clickable" alt="help" src="${webappPath}/img/button_help.png"
                         onclick="$('#div_maximum_help').slideToggle('slow')"/>
                </td>
            </tr>
            <tr class="help">
                <td colspan="3">
                    <div id="div_maximum_help" style="display: none">
                        此值显示每月允许的最大百分比
                        <br/>
                        如果这个超出这个限制，easyrec直到下个月结束将不会展示推荐<br/>
                        您可以从<br/>
                        <a target="_blank" href="${updateUrl}">${updateUrl}</a><br/>
                        下载easyrec，并在您自己的服务器上托管easyrec。
                        <%-- or consult <a target="_blank" href="${easyrecBiz}">${easyrecBiz}</a> for<br />
                        upgrading options.--%>
                        <hr/>
                    </div>
                </td>
            </tr>
            <tr>
                <td>总的项目数
                   </td>
                <td align="right">${tenantStatistics.items}</td>
                <td width="25px" align="right" style="padding-right: 2px">
                    <img class="clickable" alt="help" src="${webappPath}/img/button_help.png"
                         onclick="$('#div_items_help').slideToggle('slow')"/>
                </td>
            </tr>
            <tr class="help">
                <td colspan="3">
                    <div id="div_items_help" style="display: none">
                        使用
                        <a href="${webappPath}/API">REST-API</a>
                        进行行为调用时的所提交的项目ID数量。
                        <hr/>
                    </div>
                </td>
            </tr>
            <tr style="background-color:#efefef;">
                <td>总的用户数
                    </td>
                <td align="right">${tenantStatistics.users}</td>
                <td width="25px" align="right" style="padding-right: 2px">
                    <img class="clickable" alt="help" src="${webappPath}/img/button_help.png"
                         onclick="$('#div_users_help').slideToggle('slow')"/>
                </td>
            </tr>
            <tr class="help">
                <td colspan="3">
                    <div id="div_users_help" style="display: none">
                        使用
                        <a href="${webappPath}/API">REST-API</a>
                        进行行为调用时所提交的用户ID的数量。
                        <hr/>
                    </div>
                </td>
            </tr>
            <tr>
                <td>每个用户的平均行为数</td>
                <td align="right">${tenantStatistics.averageActionsPerUser}</td>
                <td width="25px" align="right" style="padding-right: 2px">
                    <img class="clickable" alt="help" src="${webappPath}/img/button_help.png"
                         onclick="$('#div_averageActionsPerUser_help').slideToggle('slow')"/>
                </td>
            </tr>
            <tr class="help">
                <td colspan="3">
                    <div id="div_averageActionsPerUser_help" style="display: none">
                        当访问您的网站时，每个用户的平均行为数。
                        <hr/>
                    </div>
                </td>
            </tr>
            <tr style="background-color:#efefef;">
                <td>推荐覆盖率</td>
                <td align="right">${tenantStatistics.recommendationCoverage} %</td>
                <td width="25px" align="right" style="padding-right: 2px">
                    <img class="clickable" alt="help" src="${webappPath}/img/button_help.png"
                         onclick="$('#div_recommendationCoverage_help').slideToggle('slow')"/>
                </td>
            </tr>
            <tr class="help">
                <td colspan="3">
                    <div id="div_recommendationCoverage_help" style="display: none">
                        推荐覆盖率是如果一个随机用户查看一个项目，那么他也会从查看的项目中得到推荐的概率
                        <br/>
                        <table style="width: 500px;">
                            <tr>
                                <td>推荐覆盖率 (%) = 100 *</td>
                                <td>
                                    <table style="width: 300px;">
                                        <tr style="border-bottom: solid 1px #454545;">
                                            <td valign="baseline" align="center">
                                                具有规则的项目上的总行为数

                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top" align="center">总行为数</td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <hr/>
                    </div>
                </td>
            </tr>
        </table>
    </td>
</tr>
<tr>
    <td>&nbsp;</td>
</tr>
<tr>
    <td><span class="headline">用户行为数</span>
        <hr/>
    </td>
</tr>
<tr>
    <td>
        <table width="100%">
            <tr style="background-color:#efefef;">
                <td width="68%">1个行为</td>
                <td align="right">${userStatistics.users_with_1_action}</td>
                <td width="25px;"></td>
            </tr>
            <tr>
                <td>2个行为</td>
                <td align="right">${userStatistics.users_with_2_actions}</td>
                <td></td>
            </tr>
            <tr style="background-color:#efefef;">
                <td>3 - 10行为</td>
                <td align="right">${userStatistics.users_with_3_10_actions}</td>
                <td></td>
            </tr>
            <tr>
                <td>11 - 100行为</td>
                <td align="right">${userStatistics.users_with_11_100_actions}</td>
                <td></td>
            </tr>
            <tr style="background-color:#efefef;">
                <td>101及更多的行为</td>
                <td align="right">${userStatistics.users_with_101_and_more_actions}</td>
                <td></td>
            </tr>
        </table>
        <br/>
        <table id="users">
            <thead>
            <tr>
                <td></td>
            </tr>
            </thead>
            <tbody>
            <tr>
                <th scope="row">1个行为</th>
                <td>${userStatistics.users_with_1_action}</td>
            </tr>
            <tr>
                <th scope="row">2个行为</th>
                <td>${userStatistics.users_with_2_actions}</td>
            </tr>
            <tr>
                <th scope="row">3-10</th>
                <td>${userStatistics.users_with_3_10_actions}</td>
            </tr>
            <tr>
                <th scope="row">11-100</th>
                <td>${userStatistics.users_with_11_100_actions}</td>
            </tr>
            <tr>
                <th scope="row">&gt; 100个行为</th>
                <td>${userStatistics.users_with_101_and_more_actions}</td>
            </tr>
            </tbody>
        </table>
    </td>
</tr>

<tr>
    <td><br/><span class="headlineBig">规则统计</span></td>
</tr>

 <%----
         The automated Plugins statistics are generated here we use a taglib to generate a table from a XML string (log entry)

         the help data is loaded via an AJAX call.
   ----%>

   <c:forEach var="statistic" items="${assocTypeToStatistic}">
        <table class="stat">
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr style="border-bottom: 2px solid #C0C0C0;height:29px;">
            <td>
                <span class="headline">${fn:replace(fn:toLowerCase(statistic.key), "_", " ")} (provided by ${pluginRealName[statistic.key]})</span>
            </td>
            <td width="25px" align="right" style="padding-right: 2px">
                <img class="clickable" alt="help" src="${webappPath}/img/button_help.png"
                     onclick="$('#div_${statistic.key}_help').slideToggle('slow')"/>
            </td>
        </tr>
        <tr class="help">
            <td colspan="3">
                <div id="div_${statistic.key}_help" style="display: none;width:512px;">
                    <script>
                        showPluginDescription('${operatorId}', '${tenantId}', '${assocTypeToPlugin[statistic.key].uri}',
                                '${assocTypeToPlugin[statistic.key].version}', 'div_${statistic.key}_help');
                    </script>
                    <hr/>
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <texta:generatorXmlStats xml="<verbose>${statistic.value}</verbose>"/>
            </td>
        </tr>
    </table>

   </c:forEach>

 <%---- end  ----%>


<table class="stat">
    <tr>
        <td><br/><span class="headline">关联值的分布
        </span>
            <hr/>
        </td>
    </tr>
    <tr>
        <td><span>具有关联值的规则的项目数：
            </span></td>
    </tr>
    <tr>
        <td>

            <table width="100%">
                <tr style="background-color:#efefef;">
                    <td width="23px;">&lt;</td>
                    <td>20 %</td>
                    <td align="right">${ruleMinerStatistics.group1}</td>
                    <td width="25px;"></td>
                </tr>
                <tr>
                    <td>20 -</td>
                    <td>40 %</td>
                    <td align="right">${ruleMinerStatistics.group2}</td>
                    <td/>
                </tr>
                <tr style="background-color:#efefef;">
                    <td>40 -</td>
                    <td>60 %</td>
                    <td align="right">${ruleMinerStatistics.group3}</td>
                    <td/>
                </tr>
                <tr>
                    <td>60 -</td>
                    <td>80 %</td>
                    <td align="right">${ruleMinerStatistics.group4}</td>
                    <td/>
                </tr>
                <tr style="background-color:#efefef;">
                    <td>&gt;</td>
                    <td>80 %</td>
                    <td align="right">${ruleMinerStatistics.group5}</td>
                    <td/>
                </tr>
            </table>
        </td>
    </tr>
</table>
</td>
</tr>
<tr>
    <td><br/>
        <table id="rules">
            <thead>
            <tr>
                <td></td>
            </tr>
            </thead>
            <tbody>
            <tr>
                <th scope="row">&lt; 20%</th>
                <td>${ruleMinerStatistics.group1}</td>
            </tr>
            <tr>
                <th scope="row">20-40%</th>
                <td>${ruleMinerStatistics.group2}</td>
            </tr>
            <tr>
                <th scope="row">40-60%</th>
                <td>${ruleMinerStatistics.group3}</td>
            </tr>
            <tr>
                <th scope="row">60-80%</th>
                <td>${ruleMinerStatistics.group4}</td>
            </tr>
            <tr>
                <th scope="row">&gt; 80%</th>
                <td>${ruleMinerStatistics.group5}</td>
            </tr>
            </tbody>
        </table>
    </td>
</tr>
<tr>
    <td><span>
                *关联值定义一个规则的质量。
        </span>
    </td>
</tr>
</table>


<script type="text/javascript">
    // http://www.filamentgroup.com/lab/update_to_jquery_visualize_accessible_charts_with_html5_from_designing_with
    $(function()
    {

        $('#rules').hide();
        $('#rules').visualize({
            type: 'pie',
            height: '300px',
            width: '590px',
            colors: ['#cf2c2c','#cf622c','#cfb32c','#9ccf2c','#3ccf66']
        });

        $('#users').hide();
        $('#users').visualize({
            type: 'pie',
            height: '300px',
            width: '590px',
            colors: ['#cf2c2c','#cf622c','#cfb32c','#9ccf2c','#3ccf66']
        });
    });
</script>
<br/><br/><br/><br/><br/><br/><br/>
</div>
 