<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="easyrec" uri="/WEB-INF/tagLib.tld" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>
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

<script type="text/javascript">

    var createDialog = $("#createNewAssocTypeForm").dialog(
            {
                modal:true,
                title:"Create a new Assoc Type",
                width:430,
                height:300,
                resizable:false,
                autoOpen:false
            });

    function showCreateNewAssocTypeForm() {
       createDialog.dialog("open")
    }

    function submitAssocTypeForm() {
        var parameters = jQuery.param($(".ui-dialog:visible #assocTypeForm input"));
        $(".ui-tabs-panel:not(.ui-tabs-hide)").load("${webappPath}/tenant/assoctypes?" + parameters);
        createDialog.dialog("close")
    }

</script>


<h2>关联类型管理器</h2>

<p>使用关联类型管理器去创建
   <a href="https://sourceforge.net/p/easyrec/wiki/Assoc Types/" target="_blank">关联类型</a>。
    关联类型被用来定义两个项目之间的关系。作为管理员，您可以为每个关联类型设置特定的插件。

</p>


    <div class="info">
        <b>注意:</b>关联类型一旦被创建就不能再被移除！
    </div>

    <c:if test="${error!= null}">
        <div class="error">${error}</div>
    </c:if>

    <br>

    <h3> ${tenantId}的关联类型</h3>
    <a href="javascript:void(0)" onclick="showCreateNewAssocTypeForm()">
        <img src="${webappPath}/img/cluster_manager_plus.png"/>
        添加新的关联类型
    </a>

    <display:table name="assocTypes" class="tableData" id="row" pagesize="0">
        <display:column title="关联类型名" sortable="false">
            ${row}
        </display:column>
    </display:table>


<div id="createNewAssocTypeForm" style="display:none;">
    <h1>创建新的关联类型</h1>

    <p>
        在这您可以为您的租户创建一个新的关联类型。创建之后您就可以在API调用的时候使用它。

    </p>

    <div>
        <form id="assocTypeForm" onsubmit="submitAssocTypeForm(); return false;">
            <input type="hidden" name="tenantId" value="${tenantId}"/>
            <input type="hidden" name="operatorId" value="${operatorId}"/>

            <label for="assocTypeName"> 输入新的关联类型名 </label>
            <input type="text" id="assocTypeName" name="assocTypeName"/>

            <input type="submit" class="button--filled easyrecblue" style="font-family: Arial" id="submitSearch" name="submit"
                   value="创建"/>
        </form>
    </div>
</div>

