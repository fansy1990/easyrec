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

    <span class="headlineBig">编辑 '${tenant.stringId}'</span>

    <p>在这里您可以编辑URL和对您的
        <easyrec:wikiLink name="租户"/>的描述。
    </p>

    <div id="createTenantForm" class="contentContainer">
        <div id="error" class="error" style="display:none;"></div>
        <form id="registerOperator" action="" onsubmit="javascript:return false;">
            <label for="url">URL:</label>

            <p>在此处输入您的网站的URL。easyrec服务将自动将此URL添加到通过API调用发送的相对URL中。
                您稍后可以在租户配置中编辑此值。

            </p>

            <p>如果您通过API发送项目的绝对URL，此设置不会影响为每个项目存储的URL，并且更难移动到其他领域。
                如果没有很好的理由，建议您使用项目的相对URL。
            </p>
            <input id="url" name="url" type="text" size="40" value="${tenant.url}"/>
            <br/>
            <label for="easyrec_description">描述:</label>

            <p> 提供您的租户的可选描述(最多250个字符)。您稍后可以在租户配置中编辑此值。

            </p>

            <div id="charCountInfo">

            </div>
            <textarea id="easyrec_description" name="easyrec_description" type="text">${tenant.description}</textarea>

            <a id="createTenantSubmit" onclick="updateTenant('${operatorId}', '${tenant.stringId}')" href="#" class="button--filled easyrecblue">更新
                <!--<img alt="update" src="${webappPath}/img/button_update.png"/>-->
            </a>
        </form>
    </div>
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
            $('#' + infodiv).html('您还剩余 ' + (limit - textlength) + ' 个字符。');
            return true;
        }
    }

    $(function() {
        $('#easyrec_description').keyup(function() {
            limitChars('easyrec_description', 250, 'charCountInfo');
        })
        var textlength = $('#easyrec_description').val().length;
        $('#charCountInfo').html('您还剩余 ' + (250 - textlength) + '个字符。');
    });
</script>

