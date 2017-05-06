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

    var createDialog = $("#createNewActionTypeForm").dialog(
            {
                modal:true,
                title:"Create a new Action Type",
                width:430,
                height:300,
                resizable:false,
                autoOpen:false
            });
            
    var editDialog = $("#editActionTypeForm").dialog(
            {
                modal:true,
                title:"Edit Action Type",
                width:430,
                height:300,
                resizable:false,
                autoOpen:false,
                open: function() {
                    var actionType = $(this).data('actionType');
                    console.log(actionType);
                    $("#editActionTypeForm #editActionTypeName").val(actionType.name);
                    $("#editActionTypeForm #editActionTypeHasValue").attr("checked", actionType.hasValue);
                    $("#editActionTypeForm #editActionTypeWeight").val(actionType.weight);
                }
            });

    function showCreateNewActionTypeForm() {
       createDialog.dialog("open");
    }
    
    function showEditNewActionTypeForm(id, name, hasValue, weight) {
       var actionType = {id: id, name: name, hasValue: hasValue, weight: weight};
       console.log(actionType);
       editDialog.data('actionType', actionType).dialog("open");
    }

    function submitActionTypeForm() {
        var params = $.merge($(".ui-dialog:visible" ).find("#actionTypeHasValue:checked"),$(".ui-dialog:visible #actionTypeForm input:not([type=checkbox])"));
        params = $.merge(params, $(".ui-dialog:visible #actionTypeWeight value"));
        var parameters = jQuery.param(params);        
        $(".ui-tabs-panel:not(.ui-tabs-hide)").load("${webappPath}/tenant/actiontypes?" + parameters);
        createDialog.dialog("close");
    }
    
    function submitEditActionTypeForm() {
        var params = $.merge($(".ui-dialog:visible" ).find("#editActionTypeHasValue:checked"),$(".ui-dialog:visible #editActionTypeForm input:not([type=checkbox])"));
        params = $.merge(params, $(".ui-dialog:visible #editActionTypeWeight value"));
        var parameters = jQuery.param(params);        
        $(".ui-tabs-panel:not(.ui-tabs-hide)").load("${webappPath}/tenant/actiontypes?" + parameters);
        editDialog.dialog("close");
    }
    
</script>
<div>

    <h2>行为类型管理器</h2>

    <p>使用行为类型管理器去创建
       <a href="https://sourceforge.net/p/easyrec/wiki/Action Types/" target="_blank">行为类型</a>。
        行为类型是指您提供给华联云谷的行为的所属类型。
        创建行为类型之后您就可以在API调用时使用它。

    </p>


        <div class="info">
            <b>注意:</b> 一旦行为类型被创建之后就不能再被移除！
        </div>

        <c:if test="${error!= null}">
            <div class="error">${error}</div>
        </c:if>

        <br>

        <h3> ${tenantId}的行为类型</h3>
        <a href="javascript:void(0)" onclick="showCreateNewItemTypeForm()">
            <img src="${webappPath}/img/cluster_manager_plus.png"/>
            添加新的行为类型
        </a>

        <display:table name="actionTypes" class="tableData" id="row" pagesize="0">
            <display:column title="行为类型名" sortable="false">
                ${row.name}
            </display:column>
            <display:column title="具有值" sortable="false">
                ${row.hasValue}
            </display:column>
            <display:column title="权重" sortable="false">
                ${row.weight}
            </display:column>
            <display:column title="行为" sortable="false">
                <a href="javascript:void(0);" onclick="showEditNewActionTypeForm(${row.id}, '${row.name}', ${row.hasValue}, ${row.weight})">编辑</a>
            </display:column>
        </display:table>


    <div id="createNewActionTypeForm" style="display:none;">
        <h1>创建新的行为类型
            </h1>

        <p>
            这里您可以为您的租户创建一个新的行为类型。在这创建之后您就可以在API调用时使用它。
        </p>

        <div>
            <form id="actionTypeForm" onsubmit="submitActionTypeForm(); return false;">
                <input type="hidden" name="tenantId" value="${tenantId}"/>
                <input type="hidden" name="operatorId" value="${operatorId}"/>

                <label for="actionTypeName"> 输入新的行为类型名
                     </label>
                <input type="text" id="actionTypeName" name="actionTypeName"/>

                <br>

                <label for="actionTypeHasValue"> 您想使用行为类型的值吗?
                     </label>
                <input type="checkbox" id="actionTypeHasValue" name="actionTypeHasValue" value="true"/> 是

                <br>
                
                <label for="actionTypeWeight"> 在这里，您可以为稍后可用于加权计算的操作类型输入自定义权重 </label>
                <input type="text" id="actionTypeWeight" name="actionTypeWeight" value="1"/>

                <br>

                <input type="submit" class="button--filled easyrecblue" style="font-family: Arial" id="submitActionType" name="submit"
                   value="创建"/>
            </form>
        </div>
    </div>
                
    <div id="editActionTypeForm" style="display:none;">
        <h1>Edit action type</h1>
        <div>
            <form id="editActionTypeForm" onsubmit="submitEditActionTypeForm(); return false;">
                <input type="hidden" name="tenantId" value="${tenantId}"/>
                <input type="hidden" name="operatorId" value="${operatorId}"/>

                <label for="editActionTypeName"> Enter the name of the new action type </label>
                <input type="text" id="editActionTypeName" name="editActionTypeName" disabled="true"/>

                <br>

                <label for="editActionTypeHasValue"> Do you want to use action type values? </label>
                <input type="checkbox" id="editActionTypeHasValue" name="editActionTypeHasValue" value="true"/> Yes

                <br>
                
                <label for="editActionTypeWeight"> Here you can enter a custom weight for the action type that can be used for weighted calculations later on </label>
                <input type="text" id="editActionTypeWeight" name="editActionTypeWeight" value="1"/>

                <br>

                <input type="submit" class="button--filled easyrecblue" style="font-family: Arial" id="submitEditActionType" name="submit"
                   value="Edit"/>
            </form>
        </div>
    </div>

</div>
