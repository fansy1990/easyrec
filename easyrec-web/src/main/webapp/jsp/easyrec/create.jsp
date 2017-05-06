<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

<script src="${webappPath}/js/item.js" type="text/javascript"></script>
<script src="${webappPath}/js/easyrec.js" type="text/javascript"></script>

<div class="appendbody" style="min-height: 400px;">
    <jsp:include page="menu.jsp"/>

    <span class="headlineBig">创建一个新的租户
        </span>

    <p>在这里您可以创建一个新的<easyrec:wikiLink name="租户"/>。 租户名将会被应用在
        <a href="${webappPath}/API">API</a> 调用中，用来在当你产生操作或接收推荐时识别您的网站 。
        如果您想在您的本地主机上测试华联云谷推荐平台，您可以使用 http://127.0.0.1/作为URL。如果您并不太清楚
        怎样去启动华联云谷推荐平台，您可以阅读
        <easyrec:wikiLink name="开启华联云谷"/> 指导说明。
    </p>

    <div id="createTenantForm" class="contentContainer">
        <div id="error" class="error" style="display:none;"></div>
        <form id="registerOperator" action="">
            <label for="tenantId">租户ID:</label>

            <p>租户ID用于在API调用中标识您的网站。这个ID之后不能再被修改。<br>
                使用仅包含以下字符的机读名称: A-Z a-z 0-9 和 _
            </p>
            <input id="tenantId" name="tenantId" type="text" size="40" maxlength="50"/>

            <label for="url">URL:</label>

            <p>在这里输入您的网站的URL。华联云谷推荐平台服务将自动将此URL添加到通过API调用发送的相对URL中。
                您稍后可以在租户配置中编辑此值。

            </p>
            <input id="url" name="url" type="text" size="40" value="http://"/>
            <br/>
            <label for="easyrec_description">描述:</label>

            <p>
                提供您的租户的可选描述(最多250个字符)。您稍后可以在租户配置中编辑此值。
            </p>

            <div id="charCountInfo">

            </div>
            <textarea id="easyrec_description" name="easyrec_description" type="text"></textarea>

            <a id="createTenantSubmit" onclick="registerTenant('${operatorId}')" href="#" class="button--filled easyrecblue">创建
                <!--<img alt="create" src="${webappPath}/img/button_create.gif"/>-->
            </a>
        </form>
    </div>
</div>


<div id="followingSteps" style="display:none;">
    <img src="${webappPath}/img/success.gif" style="float:left;"/>

    <p>您的租户已经成功创建了！现在您可以使用您的租户ID和API密钥将操作发送到华联云谷推荐平台服务。

    </p>

     <jsp:include page="followingsteps.jsp"/>
</div>


<script language="javascript">
    function limitChars(textid, limit, infodiv) {
        var text = $('#' + textid).val();
        var textlength = text.length;
        if (textlength > limit) {
            $('#' + infodiv).html('您不能超过 ' + limit + ' 个字符!');
            $('#' + textid).val(text.substr(0, limit));
            return false;
        }
        else {
            $('#' + infodiv).html('您还有 ' + (limit - textlength) + '个字符。');
            return true;
        }
    }

    $(function() {
        $('#easyrec_description').keyup(function() {
            limitChars('easyrec_description', 250, 'charCountInfo');
        })
        var textlength = $('#easyrec_description').val().length;
        $('#charCountInfo').html('您还剩余 ' + (250 - textlength) + ' 个字符。');
    });
</script>