<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%--
    Document   : apitestjson
    Created on : 19.08.2015, 11:20:15
    Author     : stephan
--%>
<!--<div ng-app="easyrec">-->
<div ng-controller="TestProfileController">
    <br/>
    <label id="host">Host: {{host}}</label><br/>
    <br/>
<!--    <input id="host" ng-model="host" style="width:100%" value="http://localhost:8080/easyrec-web/api/1.1/json/profile/"><br>-->
    配置API调用<br/>
    <select ng-model="apicall" ng-options="call.name group by call.method for call in calls" id="servletname" style="width:30%;">
    </select>
    {{apicall}}
    <div ng-hide="apicall.method === 'GET' || apicall.method === 'DELETE'" >
        <input type="radio" ng-model="encode" value="json">json
        <input type="radio" ng-model="encode" value="form">x-www-form-urlencoded<br/>
    </div>
    <hr/>
    <label id="apikey" >API 密钥: {{apikey}}</label><br/>
    <label id="tenantid" >租户 ID: {{tenantid}}</label><br/>
    <br>
    项目ID<input ng-model="itemid" id="itemid" style="width:100%"><br/>
    项目类型<input ng-model="itemtype" id="itemtype" style="width:100%"><br/>
    <div ng-show="apicall.name === 'storeitemwithprofile'">
       项目描述 <input ng-model="itemdescription" id="itemdescription" style="width:100%"><br/>
       项目url <input ng-model="itemurl" id="itemurl" style="width:100%"><br/>
        项目图片url<input ng-model="itemimageurl" id="itemimageurl" style="width:100%"><br/>
    </div>
    <hr/>
    <div ng-show="apicall.name === 'store' || apicall.name === 'storeitemwithprofile'">
        简介<input ng-model="profile" id="profile" style="width:100%" /><br/>
    </div>
    <div ng-show="apicall.name === 'field/store' || apicall.name === 'field/push' || apicall.name === 'field/load' || apicall.name === 'field/delete'">
        路径<input ng-model="path" id="path" style="width:100%" /><br/>
    </div>
    <div ng-show="apicall.name === 'field/store'">
       密钥<input ng-model="key" id="key" style="width:100%" /><br/>
    </div>
    <div ng-show="apicall.name === 'field/store' || apicall.name === 'field/push'">
        值<input ng-model="value" id="value" style="width:100%" /><br/>
    </div>
    <label>请求:</label><br/>
    {{apicall.method}} {{host}}{{apicall.name}}?apikey={{apikey}}&tenantid={{tenantid}}&itemid={{itemid}}&itemtype={{itemtype}}
    <span ng-show="apicall.name === 'field/load' || apicall.name === 'field/delete'">&path={{path}}</span>
    <a href="#" class="button--filled easyrecblue" ng-click="req()">发送操作</a><br/>
    <label>请求:</label><br/>
    状态: {{status}}<br/>
   数据: {{data}}
</div>
<!--    </div>-->
