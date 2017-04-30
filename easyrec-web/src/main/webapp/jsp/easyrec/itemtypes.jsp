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

    var createDialog = $("#createNewItemTypeForm").dialog(
            {
                modal:true,
                title:"Create a new Item Type",
                width:430,
                height:300,
                resizable:false,
                autoOpen:false
            });

    function showCreateNewItemTypeForm() {
       createDialog.dialog("open")
    }

    function submitItemTypeForm() {
        var parameters = jQuery.param($(".ui-dialog:visible #itemTypeForm input"));
        $(".ui-tabs-panel:not(.ui-tabs-hide)").load("${webappPath}/tenant/itemtypes?" + parameters);
        createDialog.dialog("close")
    }

</script>

<div>
    <h2>项目类型管理器</h2>

    <p>使用项目类型管理器去创建<a href="https://sourceforge.net/p/easyrec/wiki/Item%20Types/" target="_blank">项目类型</a>.
        项目类型是指您的项目的主要类别，例如书、音乐或电影。
        创建一个项目类型之后您就可以在API请求时调用它。

    </p>

    <p>
        (分组可以在
        <a href="${webappPath}/tenant/clustermanager?tenantId=${tenantId}&operatorId=${operatorId}">分组管理器</a>
        中被管理，并且描述项目的自定义集合。
        使用它去创建项目类型的子类别(例如“流行”,“摇滚”，“另类”是音乐项目的子类别)，或者产生特殊的推荐例如“圣诞节”或者“春季系列”)。
    </p>


    <div class="info">
        <b>注意:</b>
        一旦一个项目类别被创建后就不能再被移除！
    </div>

    <c:if test="${error!= null}">
        <div class="error">${error}</div>
    </c:if>

    <br>

    <h3>${tenantId}的项目类别</h3>
    <a href="javascript:void(0)" onclick="showCreateNewItemTypeForm()">
        <img src="${webappPath}/img/cluster_manager_plus.png"/>
       添加新的项目类别
    </a>

    <display:table name="itemTypes" class="tableData" id="row" pagesize="0">
        <display:column title="项目类型名" sortable="false">
            ${row}
        </display:column>
    </display:table>


    <div id="createNewItemTypeForm" style="display:none;">
        <h1>创建一个新的项目类别</h1>

        <p>在这里你可以为你的租户创建一个新的项目类型。在这创建之后您就可以在API调用时使用。
        </p>

        <div>
            <form id="itemTypeForm" onsubmit="submitItemTypeForm(); return false;">
                <input type="hidden" name="tenantId" value="${tenantId}"/>
                <input type="hidden" name="operatorId" value="${operatorId}"/>

                <label for="itemTypeName">输入新的项目类型名 </label>
                <input type="text" id="itemTypeName" name="itemTypeName"/>
                
                <br>

                <input type="submit" class="button--filled easyrecblue" style="font-family: Arial" id="submitSearch" name="submit"
                   value="创建"/>
            </form>
        </div>
    </div>

</div>