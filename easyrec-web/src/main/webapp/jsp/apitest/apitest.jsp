<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%--
    Document   : apitest
    Created on : 18.08.2015, 14:49:51
    Author     : stephan
--%>

<div ng-controller="TestController">
    <br/>
    <label id="host">Host: {{host}}</label><br/>
    <br/>
<!--    <input id="host" ng-model="host" style="width:100%" value="http://localhost:8080/easyrec-web/api/1.1/json/profile/"><br>-->
    API 调用<br/>
    <select ng-model="apicall" ng-options="call.name group by call.type for call in calls" id="servletname" style="width:30%;">
    </select>

<hr/>
    <label id="apikey" >API 密钥: {{apikey}}</label><br/>
    <label id="tenantid" >租户 ID: {{tenantid}}</label><br/>
<br>
<div ng-hide="apicall.type === 'Rankings' || apicall.type === 'Cluster' || apicall.type === 'Import & Other'">
会话ID*<input ng-model="sessionid" id="sessionid" style="width:100%"><br>
</div>
<div ng-hide="(apicall.type === 'Rankings' && (apicall.name !== 'bestrateditems' && apicall.name !== 'worstrateditems'))  || apicall.type === 'Cluster' || apicall.type === 'Import & Other'">
用户ID<input ng-model="userid" id="userid" style="width:100%"><br>
</div>
<div ng-show="(apicall.type === 'Actions' && apicall.name !== 'track') || (apicall.type === 'Recommendations' && (apicall.name !== 'recommendationsforuser') && (apicall.name !== 'actionhistoryforuser')) || apicall.name === 'setitemactive' || apicall.name === 'importitem'">
项目ID*<input ng-model="itemid" id="itemid" style="width:100%"><br>
</div>
<div ng-show="(apicall.type === 'Actions' && apicall.name !== 'track') || (apicall.type === 'Recommendations' && (apicall.name !== 'recommendationsforuser') && (apicall.name !== 'actionhistoryforuser')) || apicall.name === 'setitemactive' || apicall.name === 'importitem' || apicall.name === 'additemtype' || apicall.name === 'deleteitemtype'">
项目类型<input ng-model="itemtype" id="itemtype" style="width:100%"><br>
</div>
<div ng-show="(apicall.type === 'Actions' && apicall.name !== 'track') || apicall.name === 'importitem'">
<hr/>
项目描述*<input ng-model="itemdescription" id="itemdescription" style="width:100%"><br>
项目路径*<input ng-model="itemurl" id="itemurl" style="width:100%"><br>
项目图片路径<input ng-model="itemimageurl" id="itemimageurl" style="width:100%"><br>
</div>
<div ng-show="apicall.type === 'Actions' && apicall.name !== 'track'">
行为信息<input ng-model="actioninfo" id="actioninfo" style="width:100%"><br>
</div>
<div ng-show="apicall.name === 'track' || apicall.name === 'importrule'">
<hr/>
ID到项目<input ng-model="itemfromid" id="itemid" style="width:100%"><br>
类型到项目<input ng-model="itemfromtype" id="itemtype" style="width:100%"><br>
项目到ID*<input ng-model="itemtoid" id="itemdescription" style="width:100%"><br>
项目到类型<input ng-model="itemtotype" id="itemurl" style="width:100%"><br>
</div>
<div ng-show="apicall.name === 'track'">
推荐类型<input ng-model="rectype" id="itemimageurl" style="width:100%"><br>
</div>
<div ng-hide="apicall.name === 'track' || apicall.type !== 'Actions'">操作时间<input id="actiontime" style="width:100%"><br></div>
<div ng-show="apicall.name === 'rate'">
评分值*<input ng-model="ratingvalue" id="ratingvalue" style="width:100%"><br>
</div>
<div ng-show="apicall.name === 'sendaction' || apicall.name === 'recommendationsforuser' || apicall.name === 'actionhistoryforuser'">
操作类型*<input ng-model="actiontype" id="actiontype" style="width:100%"><br>
</div>
<div ng-show="apicall.name === 'sendaction'">
操作值<input ng-model="actionvalue" id="actionvalue" style="width:100%"><br>
</div>
<div ng-show="apicall.type === 'Recommendations' || apicall.type === 'Rankings' || apicall.name === 'itemsofcluster'">
<hr>
抵消<input ng-model="offset" id="offset" style="width:100%"><br>
结果数<input ng-model="numberOfResults" id="numberOfResults" style="width:100%"><br>
要求项目类型<input ng-model="requesteditemtype" id="requesteditemtype" style="width:100%"><br>
简介<input ng-model="withProfile" id="withProfile" style="width:100%"><br>
</div>
<div ng-show="apicall.type === 'Rankings'">
时间范围<input ng-model="timeRange" id="timeRange" style="width:100%"><br>
开始日期<input ng-model="startDate" id="startDate" style="width:100%"><br>
结束日期<input ng-model="endDate" id="endDate" style="width:100%"><br>
</div>
<div ng-show="apicall.name === 'itemsofcluster' || (apicall.type === 'Rankings' && (apicall.name !== 'bestrateditems' && apicall.name !== 'worstrateditems')) || apicall.name === 'createcluster' ">
分组ID<input ng-model="clusterid" id="clusterid" style="width:100%"><br>
</div>
<div ng-show="apicall.name === 'itemsofcluster'">
<hr/>
策略<input ng-model="strategy" id="strategy" style="width:100%"><br>
usefallback<input ng-model="usefallback" id="usefallback" style="width:100%"><br>
</div>
<hr/>
<div ng-show="apicall.name === 'createcluster'">
分组描述<input ng-model="clusterdescription" id="clusterdescription" style="width:100%"><br>
clusterparent<input ng-model="clusterparent" id="clusterparent" style="width:100%"><br>
</div>
<div ng-show="apicall.name === 'relateditems' || apicall.name === 'recommendationsforuser' || apicall.name === 'importrule'">
关联类型<input ng-model="assoctype" id="assoctype" style="width:100%"><br>
</div>
<div ng-show="apicall.name === 'importrule'">
关联值<input ng-model="assocvalue" id="assocvalue" style="width:100%"><br>
</div>
<div ng-show="apicall.name === 'setitemactive'">
激活<input ng-model="isactive" id="active" style="width:100%"><br>
</div>
<div ng-show="apicall.name === 'additemtype'">
可视化<input ng-model="visible" id="visible" style="width:100%"><br>
</div>
令牌<input ng-model="token" id="token" style="width:100%"><br>
<label>请求:</label><br/>
获得 {{apicall.method}} {{host}}{{apicall.name}}?apikey={{apikey}}&tenantid={{tenantid}}<span ng-hide="apicall.type === 'Rankings' || apicall.type === 'Cluster' || apicall.type === 'Import & Other'">&sessionid={{sessionid}}</span><span ng-hide="(apicall.type === 'Rankings' && (apicall.name !== 'bestrateditems' && apicall.name !== 'worstrateditems'))  || apicall.type === 'Cluster' || apicall.type === 'Import & Other'">&userid={{userid}}</span><span ng-show="(apicall.type === 'Actions' && apicall.name !== 'track') || (apicall.type === 'Recommendations' && (apicall.name !== 'recommendationsforuser') && (apicall.name !== 'actionhistoryforuser')) || apicall.name === 'setitemactive' || apicall.name === 'importitem'">&itemid={{itemid}}&itemtype={{itemtype}}</span><span ng-show="(apicall.type === 'Actions' && apicall.name !== 'track') || apicall.name === 'importitem'">&itemdescription={{itemdescription}}&itemurl={{itemurl}}&itemimageurl={{itemimageurl}}</span><span ng-show="apicall.type === 'Actions' && apicall.name !== 'track'">&actioninfo={{actioninfo}}</span><span ng-show="apicall.name === 'track' || apicall.name === 'importrule'">&itemfromid={{itemfromid}}&itemfromtype={{itemfromtype}}&itemtoid={{itemtoid}}&itemtotype={{itemtotype}}</span><span ng-show="apicall.name === 'track'">&rectype={{rectype}}</span><span ng-hide="apicall.name === 'track' || apicall.type !== 'Actions'">&actiontime={{actiontime}}</span><span ng-show="apicall.name === 'rate'">&ratingvalue={{ratingvalue}}</span><span ng-show="apicall.name === 'sendaction' || apicall.name === 'recommendationsforuser' || apicall.name === 'actionhistoryforuser'">&actiontype={{actiontype}}</span><span ng-show="apicall.name === 'sendaction'">&actionvalue={{actionvalue}}</span><span ng-show="apicall.type === 'Recommendations' || apicall.type === 'Rankings' || apicall.name === 'itemsofcluster'">&numberOfResults={{numberOfResults}}&requesteditemtype={{requesteditemtype}}&withProfile={{withProfile}}</span><span ng-show="apicall.type === 'Rankings'">&timeRange={{timeRange}}&startDate={{startDate}}&endDate={{endDate}}</span><span ng-show="apicall.name === 'itemsofcluster' || (apicall.type === 'Rankings' && (apicall.name !== 'bestrateditems' && apicall.name !== 'worstrateditems')) || apicall.name === 'createcluster' ">&clusterid={{clusterid}}</span><span ng-show="apicall.name === 'itemsofcluster'">&strategy={{strategy}}&usefallback={{usefallback}}</span><span ng-show="apicall.name === 'createcluster'">&clusterdescription={{clusterdescription}}&clusterparent={{clusterparent}}</span><span ng-show="apicall.name === 'relateditems' || apicall.name === 'recommendationsforuser' || apicall.name === 'importrule'">&assoctype={{assoctype}}</span><span ng-show="apicall.name === 'importrule'">&assocvalue={{assoctype}}</span><span ng-show="apicall.name === 'setitemactive'">&active={{isactive}}</span>&token={{token}}
<br/>
<a href="#" class="button--filled easyrecblue" ng-click="req()">发送操作</a><br/>
<label>结果:</label><br/>
状态: {{status}}<br/>
数据: {{data}}
</div>

