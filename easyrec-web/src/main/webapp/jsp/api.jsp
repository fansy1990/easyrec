<%@ taglib prefix="easyrec" uri="/WEB-INF/tagLib.tld" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%--
  ~ Copyright 2015 Research Studios Austria Forschungsgesellschaft mBH
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
<script src="${webappPath}/js/angular/angular.min.js" type="text/javascript"></script>
<script src="${webappPath}/api-js/angularjs/easyrec.js" type="text/javascript"></script>
<script>
    var easyrec = angular.module('easyrec', ['easyrecControllers', 'easyrecServices']);
    
    easyrec.config(['easyrecProvider', function(easyrecProvider){
        easyrecProvider.setBaseUrl('${webappPath}');
        easyrecProvider.setApiKey('${apikey}');
        easyrecProvider.setTenant('${tenantId}');     
    }]);
    
    var easyrecControllers = angular.module('easyrecControllers', []);
    
    easyrecControllers.controller('MenuController', ['$scope',
        function ($scope) {
            
            $scope.templates = [
                {name: 'API 文档',
                url: 'apidoc'},
                {name: '测试 API',
                url: '${webappPath}/apitest?operatorId=${operatorId}&tenantId=${tenantId}'},
                {name: '测试API配置',
                url: '${webappPath}/apitestprofile?operatorId=${operatorId}&tenantId=${tenantId}'}
            ];
            
            $scope.setActive = function(i) {
                $scope.active = $scope.templates[i];
            };
            
            $scope.active = $scope.templates[0];
            
        }
    ]);
    
    easyrecControllers.controller('TestController', ['$scope', '$http', 'easyrec',
        function ($scope, $http, easyrec) {
            $scope.calls = [
                {name: 'view', type :'Actions'},
                {name: 'buy', type :'Actions'},
                {name: 'rate', type :'Actions'},
                {name: 'sendaction', type :'Actions'},    
                {name: 'track', type :'Actions'},
                {name: 'otherusersalsoviewed', type :'Recommendations'},
                {name: 'otherusersalsobought', type :'Recommendations'},
                {name: 'itemsratedgoodbyotherusers', type :'Recommendations'},
                {name: 'relateditems',type :'Recommendations'},
                {name: 'recommendationsforuser',type :'Recommendations'},
                {name: 'actionhistoryforuser',type :'Recommendations'},
                {name: 'mostvieweditems',type :'Rankings'},
                {name: 'mostboughtitems',type :'Rankings'},
                {name: 'mostrateditems',type :'Rankings'},
                {name: 'bestrateditems',type :'Rankings'},
                {name: 'worstrateditems',type :'Rankings'},
                {name: 'clusters',type :'Cluster'},
                {name: 'itemsofcluster',type :'Cluster'},
                {name: 'createcluster',type :'Cluster'},
                {name: 'importrule',type :'Import & Other'},
                {name: 'importitem',type :'Import & Other'},
                {name: 'setitemactive',type :'Import & Other'},
                {name: 'itemtypes',type :'Import & Other'},
                {name: 'additemtype',type :'Import & Other'},
                {name: 'deleteitemtype',type :'Import & Other'}
            ];
            
            $scope.host = "${webappPath}/api/1.1/json/";
            $scope.apicall = $scope.calls[0];
            $scope.apikey = "${apikey}";
            $scope.tenantid = "${tenantId}";
            
            $scope.req = function() {
                       
                switch ($scope.apicall.name) {
                    case 'view':
                        easyrec.view($scope.sessionid, 
                                $scope.itemid,
                                $scope.itemtype,
                                $scope.itemdescription,
                                $scope.itemurl,
                                $scope.itemimageurl,
                                $scope.userid,
                                $scope.actioninfo,
                                $scope.actiontime,
                                $scope.token).then(
                            function(data, status) {
                                $scope.status = status;
                                $scope.data = data;
                                }, function(data, status) {
                                $scope.status = status;
                                $scope.data = data || "Request failed"; 
                        });
                        break;
                    case 'buy':
                        easyrec.buy($scope.sessionid, 
                                $scope.itemid,
                                $scope.itemtype,
                                $scope.itemdescription,
                                $scope.itemurl,
                                $scope.itemimageurl,
                                $scope.userid,
                                $scope.actioninfo,
                                $scope.actiontime,
                                $scope.token).then(
                            function(data, status) {
                                $scope.status = status;
                                $scope.data = data;
                                }, function(data, status) {
                                $scope.status = status;
                                $scope.data = data || "Request failed"; 
                        });
                        break;
                    case 'rate':
                        easyrec.rate($scope.sessionid, 
                                $scope.itemid,
                                $scope.itemtype,
                                $scope.itemdescription,
                                $scope.itemurl,
                                $scope.itemimageurl,
                                $scope.userid,
                                $scope.actioninfo,
                                $scope.ratingvalue,
                                $scope.actiontime,
                                $scope.token).then(
                            function(data, status) {
                                $scope.status = status;
                                $scope.data = data;
                                }, function(data, status) {
                                $scope.status = status;
                                $scope.data = data || "Request failed"; 
                        });
                        break;
                    case 'sendaction':
                        easyrec.sendaction($scope.sessionid, 
                                $scope.itemid,
                                $scope.itemtype,
                                $scope.itemdescription,
                                $scope.itemurl,
                                $scope.itemimageurl,
                                $scope.userid,
                                $scope.actioninfo,
                                $scope.actiontype,
                                $scope.actionvalue,
                                $scope.actiontime,
                                $scope.token).then(
                            function(data, status) {
                                $scope.status = status;
                                $scope.data = data;
                                }, function(data, status) {
                                $scope.status = status;
                                $scope.data = data || "Request failed"; 
                        });
                        break;
                    case 'track':
                        easyrec.track($scope.sessionid, 
                                $scope.itemfromid,
                                $scope.itemfromtype,
                                $scope.itemtoid,
                                $scope.itemtotype,
                                $scope.userid,
                                $scope.rectype,
                                $scope.token).then(
                            function(data, status) {
                                $scope.status = status;
                                $scope.data = data;
                                }, function(data, status) {
                                $scope.status = status;
                                $scope.data = data || "Request failed"; 
                        });
                        break;
                    case 'otherusersalsoviewed':
                        easyrec.alsoviewed($scope.sessionid, 
                                $scope.userid,                
                                $scope.itemid,
                                $scope.itemtype,
                                $scope.offset,
                                $scope.numberOfResults,
                                $scope.requesteditemtype,
                                $scope.withProfile,
                                $scope.token).then(
                            function(data, status) {
                                $scope.status = status;
                                $scope.data = data;
                                }, function(data, status) {
                                $scope.status = status;
                                $scope.data = data || "Request failed"; 
                        });
                        break;
                    case 'otherusersalsobought':
                        easyrec.alsobought($scope.sessionid, 
                                $scope.userid,                
                                $scope.itemid,
                                $scope.itemtype,
                                $scope.offset,
                                $scope.numberOfResults,
                                $scope.requesteditemtype,
                                $scope.withProfile,
                                $scope.token).then(
                            function(data, status) {
                                $scope.status = status;
                                $scope.data = data;
                                }, function(data, status) {
                                $scope.status = status;
                                $scope.data = data || "Request failed"; 
                        });
                        break;
                    case 'itemsratedgoodbyotherusers':
                        easyrec.alsogoodrated($scope.sessionid, 
                                $scope.userid,                
                                $scope.itemid,
                                $scope.itemtype,
                                $scope.offset,
                                $scope.numberOfResults,
                                $scope.requesteditemtype,
                                $scope.withProfile,
                                $scope.token).then(
                            function(data, status) {
                                $scope.status = status;
                                $scope.data = data;
                                }, function(data, status) {
                                $scope.status = status;
                                $scope.data = data || "Request failed"; 
                        });
                        break;
                    case 'relateditems':
                        easyrec.alsoviewed($scope.sessionid, 
                                $scope.userid,                
                                $scope.itemid,
                                $scope.itemtype,
                                $scope.assoctype,
                                $scope.offset,
                                $scope.numberOfResults,
                                $scope.requesteditemtype,
                                $scope.withProfile,
                                $scope.token).then(
                            function(data, status) {
                                $scope.status = status;
                                $scope.data = data;
                                }, function(data, status) {
                                $scope.status = status;
                                $scope.data = data || "Request failed"; 
                        });
                        break;
                    case 'recommendationsforuser':
                        easyrec.recsforuser($scope.sessionid, 
                                $scope.userid,                
                                $scope.actiontype,
                                $scope.assoctype,
                                $scope.offset,
                                $scope.numberOfResults,
                                $scope.requesteditemtype,
                                $scope.withProfile,
                                $scope.token).then(
                            function(data, status) {
                                $scope.status = status;
                                $scope.data = data;
                                }, function(data, status) {
                                $scope.status = status;
                                $scope.data = data || "Request failed"; 
                        });
                        break;
                    case 'actionhistoryforuser':
                        easyrec.actionhistoryforuser($scope.sessionid, 
                                $scope.userid,                
                                $scope.actiontype,
                                $scope.offset,
                                $scope.numberOfResults,
                                $scope.requesteditemtype,
                                $scope.withProfile,
                                $scope.token).then(
                            function(data, status) {
                                $scope.status = status;
                                $scope.data = data;
                                }, function(data, status) {
                                $scope.status = status;
                                $scope.data = data || "Request failed"; 
                        });
                        break;
                    case 'mostvieweditems':
                        easyrec.mostviewed(
                                $scope.offset,
                                $scope.numberOfResults,
                                $scope.requesteditemtype,
                                $scope.withProfile,
                                $scope.timeRange,
                                $scope.startDate,
                                $scope.endDate,
                                $scope.clusterid,
                                $scope.token).then(
                            function(data, status) {
                                $scope.status = status;
                                $scope.data = data;
                                }, function(data, status) {
                                $scope.status = status;
                                $scope.data = data || "Request failed"; 
                        });
                        break;
                    case 'mostboughtitems':
                        easyrec.mostbought(
                                $scope.offset,
                                $scope.numberOfResults,
                                $scope.requesteditemtype,
                                $scope.withProfile,
                                $scope.timeRange,
                                $scope.startDate,
                                $scope.endDate,
                                $scope.clusterid,
                                $scope.token).then(
                            function(data, status) {
                                $scope.status = status;
                                $scope.data = data;
                                }, function(data, status) {
                                $scope.status = status;
                                $scope.data = data || "Request failed"; 
                        });
                        break;
                    case 'mostrateditems':
                        easyrec.mostrated(
                                $scope.offset,
                                $scope.numberOfResults,
                                $scope.requesteditemtype,
                                $scope.withProfile,
                                $scope.timeRange,
                                $scope.startDate,
                                $scope.endDate,
                                $scope.clusterid,
                                $scope.token).then(
                            function(data, status) {
                                $scope.status = status;
                                $scope.data = data;
                                }, function(data, status) {
                                $scope.status = status;
                                $scope.data = data || "Request failed"; 
                        });
                        break;
                    case 'bestrateditems':
                        easyrec.bestrated(
                                $scope.userid,
                                $scope.offset,
                                $scope.numberOfResults,
                                $scope.requesteditemtype,
                                $scope.withProfile,
                                $scope.timeRange,
                                $scope.startDate,
                                $scope.endDate,
                                $scope.clusterid,
                                $scope.token).then(
                            function(data, status) {
                                $scope.status = status;
                                $scope.data = data;
                                }, function(data, status) {
                                $scope.status = status;
                                $scope.data = data || "Request failed"; 
                        });
                        break;
                    case 'worstrateditems':
                        easyrec.worstrated(
                                $scope.userid,
                                $scope.offset,
                                $scope.numberOfResults,
                                $scope.requesteditemtype,
                                $scope.withProfile,
                                $scope.timeRange,
                                $scope.startDate,
                                $scope.endDate,
                                $scope.clusterid,
                                $scope.token).then(
                            function(data, status) {
                                $scope.status = status;
                                $scope.data = data;
                                }, function(data, status) {
                                $scope.status = status;
                                $scope.data = data || "Request failed"; 
                        });
                        break;
                    case 'clusters':
                        easyrec.clusters(
                                $scope.token).then(
                            function(data, status) {
                                $scope.status = status;
                                $scope.data = data;
                                }, function(data, status) {
                                $scope.status = status;
                                $scope.data = data || "Request failed"; 
                        });
                        break;
                    case 'itemsofcluster':
                        easyrec.itemsofcluster(
                                $scope.offset,
                                $scope.numberOfResults,
                                $scope.requesteditemtype,
                                $scope.withProfile,
                                $scope.clusterid,
                                $scope.strategy,
                                $scope.usefallback,
                                $scope.token).then(
                            function(data, status) {
                                $scope.status = status;
                                $scope.data = data;
                                }, function(data, status) {
                                $scope.status = status;
                                $scope.data = data || "Request failed"; 
                        });
                        break;
                    case 'createcluster':
                        easyrec.createcluster(
                                $scope.clusterid,
                                $scope.clusterdescription,
                                $scope.clusterparent,
                                $scope.token).then(
                            function(data, status) {
                                $scope.status = status;
                                $scope.data = data;
                                }, function(data, status) {
                                $scope.status = status;
                                $scope.data = data || "Request failed"; 
                        });
                        break;
                    case 'importrule':
                        easyrec.importrule(
                                $scope.itemfromid,
                                $scope.itemfromtype,
                                $scope.itemtoid,
                                $scope.itemtotype,
                                $scope.assoctype,
                                $scope.assocvalue,
                                $scope.token).then(
                            function(data, status) {
                                $scope.status = status;
                                $scope.data = data;
                                }, function(data, status) {
                                $scope.status = status;
                                $scope.data = data || "Request failed"; 
                        });
                        break;
                    case 'importitem':
                        easyrec.importitem(
                                $scope.itemid,
                                $scope.itemtype,
                                $scope.itemdescription,
                                $scope.itemurl,
                                $scope.itemimageurl,
                                $scope.token).then(
                            function(data, status) {
                                $scope.status = status;
                                $scope.data = data;
                                }, function(data, status) {
                                $scope.status = status;
                                $scope.data = data || "Request failed"; 
                        });
                        break;
                    case 'setitemactive':
                        easyrec.setitemactive(
                                $scope.itemid,
                                $scope.itemtype,
                                $scope.active,
                                $scope.token).then(
                            function(data, status) {
                                $scope.status = status;
                                $scope.data = data;
                                }, function(data, status) {
                                $scope.status = status;
                                $scope.data = data || "Request failed"; 
                        });
                        break;
                    case 'itemtypes':
                        easyrec.itemtypes(
                                $scope.token).then(
                            function(data, status) {
                                $scope.status = status;
                                $scope.data = data;
                                }, function(data, status) {
                                $scope.status = status;
                                $scope.data = data || "Request failed"; 
                        });
                        break;
                    case 'additemtype':
                        easyrec.additemtype(
                                $scope.token, 
                                $scope.itemtype,
                                $scope.visible).then(
                            function(data, status) {
                                $scope.status = status;
                                $scope.data = data;
                                }, function(data, status) {
                                $scope.status = status;
                                $scope.data = data || "Request failed"; 
                        });
                        break;
                    case 'deleteitemtype':
                        easyrec.deleteitemtype(
                                $scope.token,
                                $scope.itemtype).then(
                            function(data, status) {
                                $scope.status = status;
                                $scope.data = data;
                                }, function(data, status) {
                                $scope.status = status;
                                $scope.data = data || "Request failed"; 
                        });
                        break;
                }
        
//                var url = $scope.host + $scope.apicall.name;
//                var option = {
//                    apikey : $scope.apikey,
//                    tenantid : $scope.tenantid,
//                    itemid : $scope.itemid,
//                    itemtype : $scope.itemtype,
//                    itemdescription : $scope.itemdescription,
//                    itemurl : $scope.itemurl,
//                    itemimageurl : $scope.itemimageurl
//                };
//
//                var pars = {
//                    method: 'GET',
//                    url: url,
//                    params: option
//                };
//                
//                $http(pars).
//                success(function(data, status){
//                    $scope.status = status;
//                    $scope.data = data;
//                }).
//                error(function(data, status){
//                    $scope.status = status;
//                    $scope.data = data || "Request failed";
//                });
            };
        }

    ]);
    
    easyrecControllers.controller('TestProfileController', ['$scope', '$http', 
        function ($scope, $http) {
            
            /**
            * The workhorse; converts an object to x-www-form-urlencoded serialization.
            * @param {Object} obj
            * @return {String}
            */ 
           var encodeParam = function(obj) {
             var query = '', name, value, fullSubName, subName, subValue, innerObj, i;

             for(name in obj) {
               value = obj[name];

               if(value instanceof Array) {
                 for(i=0; i<value.length; ++i) {
                   subValue = value[i];
                   fullSubName = name + '[' + i + ']';
                   innerObj = {};
                   innerObj[fullSubName] = subValue;
                   query += param(innerObj) + '&';
                 }
               }
               else if(value instanceof Object) {
                 for(subName in value) {
                   subValue = value[subName];
                   fullSubName = name + '[' + subName + ']';
                   innerObj = {};
                   innerObj[fullSubName] = subValue;
                   query += param(innerObj) + '&';
                 }
               }
               else if(value !== undefined && value !== null)
                 query += encodeURIComponent(name) + '=' + encodeURIComponent(value) + '&';
             }

             return query.length ? query.substr(0, query.length - 1) : query;
           };
            
            $scope.calls = [
                {name: 'store', method :'POST'},
                {name: 'delete', method :'DELETE'},
                {name: 'load', method :'GET'},
                {name: 'field/store', method :'PUT'},
                {name: 'field/push', method :'PUT'},
                {name: 'field/load', method :'GET'},
                {name: 'field/delete', method :'DELETE'},
                {name: 'storeitemwithprofile', method :'POST'}
            ];
            
            $scope.host = "${webappPath}/api/1.1/json/profile/";
            $scope.apicall = $scope.calls[0];
            $scope.apikey = "${apikey}";
            $scope.tenantid = "${tenantId}";
            $scope.itemid = "42";
            $scope.itemtype = "ITEM";
            $scope.encode = "json";
            $scope.template =  { url : "${webappPath}/apitestprofile"};
            
            $scope.req = function() {
                
                var url = $scope.host + $scope.apicall.name;
                var option = {
                    apikey : $scope.apikey,
                    tenantid : $scope.tenantid,
                    itemid : $scope.itemid,
                    itemtype : $scope.itemtype,
                    itemdescription : $scope.itemdescription,
                    itemurl : $scope.itemurl,
                    itemimageurl : $scope.itemimageurl,
                    profile : $scope.profile,
                    path : $scope.path,
                    key : $scope.key,
                    value : $scope.value
                };
                var meth = $scope.apicall.method;
                var pars = {
                    method: meth,
                    url: url
                };
                if (meth==='GET' || meth==='DELETE') {
                    pars.params = option;
                } else {
                    if ($scope.encode==='json') {
                        pars.data = option;
                    } else {
                        pars.data = encodeParam(option);
                        pars.headers = {'Content-Type' : 'application/x-www-form-urlencoded'};
                    }
                }
                
                $http(pars).
                success(function(data, status){
                    $scope.status = status;
                    $scope.data = data;
                }).
                error(function(data, status){
                    $scope.status = status;
                    $scope.data = data || "Request failed";
                });
            };
            
    }]);
    
</script>
<div ng-app="easyrec">
    <div class="appendbody" ng-controller="MenuController">
        <h1>推荐API</h1>

        <div ng-repeat="template in templates" style="display: inline-block" ng-cloak>
            <a ng-if="active !== template" href="javascript:void(0)" ng-click="setActive($index)" style="clear:right">
                <span>{{template.name}}</span>
            </a>
            <span ng-if="active === template" class="bullmenu">{{template.name}}</span>
            <span ng-show="!$last"> &nbsp;&bull;  </span>
        </div>

        <div id="content" ng-include="active.url"/>

    </div>
</div>

<script type="text/ng-template" id="apidoc" >
    <p>

        我们通过
        <a href="https://sourceforge.net/p/easyrec/wiki/API/" target="_blank">REST API</a>
        给您提供easyrec的全部服务。
        推荐结果会以XML或者JSON的形式返回。
         <br/>
        我们也提供AngularJS服务，它包含了所有的API功能。
        您可以在我们的维基百科的
         <a href="https://sourceforge.net/p/easyrec/wiki/API/#angularjs-service" target="_blank">AngularJS 服务页面</a> 找到关于使用
        它的更多细节。<br/>
        <b>另外:</b>
        您可以在您的网站中添加一小段
        <easyrec:wikiLink name="javascript 代码" pageName="JavaScript_API_v0.98"/>
        来获得推荐<br/>
        我们建议您阅读
        <a href="https://sourceforge.net/p/easyrec/wiki/get_started/" target="_blank"> 入门指导</a>
        来开启easyrec之旅。
        如果您感觉到茫然不知所措，可以在我们的
        <a href="https://sourceforge.net/p/easyrec/forum/" target="_blank">论坛</a>
        向我们提问。
    </p>

    <br/>
    <table width="100%">
        <tr>
            <td colspan="2"><span class="headline">行为操作</span>
                <hr>
            </td>
        </tr>
        <tr style="background-color: rgb(239, 239, 239);">
            <td>
                查看
            </td>
            <td style="width:200px;height:40px;">
                <a target="_blank" href="http://sourceforge.net/p/easyrec/wiki/ActionAPI/#view">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-rest.png"/>
                </a>
                <a target="_blank"
                   href="http://easyrec.sourceforge.net/wiki/index.php?title=JavaScript_API_v0.98#Sending_Actions">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-js.png"/>
                </a>
            </td>
        </tr>
        <tr>
            <td>
                购买
            </td>
            <td>
                <a target="_blank" href="http://sourceforge.net/p/easyrec/wiki/ActionAPI/#buy">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-rest.png"/>
                </a>
                <a target="_blank"
                   href="http://easyrec.sourceforge.net/wiki/index.php?title=JavaScript_API_v0.98#Sending_Actions">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-js.png"/>
                </a>
            </td>
        </tr>
        <tr style="background-color: rgb(239, 239, 239);">
            <td>
                评分
            </td>
            <td>
                <a target="_blank" href="http://sourceforge.net/p/easyrec/wiki/ActionAPI/#rate">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-rest.png"/>
                </a>
                <a target="_blank"
                   href="http://easyrec.sourceforge.net/wiki/index.php?title=JavaScript_API_v0.98#Sending_Actions">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-js.png"/>
                </a>
            </td>
        </tr>
        <tr>
            <td>
                发送操作
            </td>
            <td>
                <a target="_blank" href="http://sourceforge.net/p/easyrec/wiki/ActionAPI/#sendaction">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-rest.png"/>
                </a>
                <a target="_blank"
                   href="http://easyrec.sourceforge.net/wiki/index.php?title=JavaScript_API_v0.98#Sending_Actions">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-js.png"/>
                </a>
            </td>
        </tr>
        <tr style="background-color: rgb(239, 239, 239);">
            <td>
                追踪
            </td>
            <td>
                <a target="_blank" href="http://sourceforge.net/p/easyrec/wiki/ActionAPI/#track">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-rest.png"/>
                </a>
            </td>
        </tr>
    </table>

    <br/>

    <table width="100%">
        <tr>
            <td colspan="2"><span class="headline">推荐</span>
                <hr>
            </td>
        </tr>
        <tr style="background-color: rgb(239, 239, 239);">
            <td>别的用户也查看了

            </td>
            <td style="width:200px;">
                <a target="_blank"
                   href="http://sourceforge.net/p/easyrec/wiki/RecommendationAPI/#other-users-also-viewed">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-rest.png"/>
                </a>
                <a target="_blank"
                   href="http://easyrec.sourceforge.net/wiki/index.php?title=JavaScript_API_v0.98#Receiving_Recommendations">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-js.png"/>
                </a>
            </td>
        </tr>
        <tr>
            <td>别的用户也购买了
            </td>
            <td>
                <a target="_blank"
                   href="http://sourceforge.net/p/easyrec/wiki/RecommendationAPI/#other-users-also-bought">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-rest.png"/>
                </a>
                <a target="_blank"
                   href="http://easyrec.sourceforge.net/wiki/index.php?title=JavaScript_API_v0.98#Receiving_Recommendations">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-js.png"/>
                </a>
            </td>
        </tr>
        <tr style="background-color: rgb(239, 239, 239);">
            <td>被其他用户评分很高的项目
            </td>
            <td>
                <a target="_blank"
                   href="http://sourceforge.net/p/easyrec/wiki/RecommendationAPI/#items-rated-good-by-other-users">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-rest.png"/>
                </a>
                <a target="_blank"
                   href="http://easyrec.sourceforge.net/wiki/index.php?title=JavaScript_API_v0.98#Receiving_Recommendations">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-js.png"/>
                </a>
            </td>
        </tr>
        <tr>
            <td>
                给用户的推荐
            </td>
            <td>
                <a target="_blank"
                   href="http://sourceforge.net/p/easyrec/wiki/RecommendationAPI/#recommendations-for-user">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-rest.png"/>
                </a>
                <a target="_blank"
                   href="http://easyrec.sourceforge.net/wiki/index.php?title=JavaScript_API_v0.98#Receiving_Recommendations">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-js.png"/>
                </a>
            </td>
        </tr>
        <tr style="background-color: rgb(239, 239, 239);">
            <td>
                相关的项目
            </td>
            <td>
                <a target="_blank"
                   href="http://sourceforge.net/p/easyrec/wiki/RecommendationAPI/#related-items">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-rest.png"/>
                </a>
                <a target="_blank"
                   href="http://easyrec.sourceforge.net/wiki/index.php?title=JavaScript_API_v0.98#Receiving_Recommendations">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-js.png"/>
                </a>
            </td>
        </tr>
        <tr>
            <td>
                用户的行为历史
            </td>
            <td>
                <a target="_blank"
                   href="http://sourceforge.net/p/easyrec/wiki/RecommendationAPI/#action-history-for-user">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-rest.png"/>
                </a>
                <a target="_blank"
                   href="http://easyrec.sourceforge.net/wiki/index.php?title=JavaScript_API_v0.98#Receiving_Recommendations">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-js.png"/>
                </a>
            </td>
        </tr>
    </table>

    <br/>

    <table width="100%">
        <tr>
            <td colspan="2"><span class="headline">邻居排名</span>
                <hr>
            </td>
        </tr>
        <tr style="background-color: rgb(239, 239, 239);">
            <td>
                被查看最多次的项目
            </td>
            <td style="width:200px;">
                <a target="_blank"
                   href="http://sourceforge.net/p/easyrec/wiki/RankingsAPI/#most-viewed-items">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-rest.png"/>
                </a>
                <a target="_blank"
                   href="http://easyrec.sourceforge.net/wiki/index.php?title=JavaScript_API_v0.98#Receiving_Rankings">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-js.png"/>
                </a>
            </td>
        </tr>
        <tr>
            <td>
                被购买最多的项目
            </td>
            <td>
                <a target="_blank"
                   href="http://sourceforge.net/p/easyrec/wiki/RankingsAPI/#most-bought-items">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-rest.png"/>
                </a>
                <a target="_blank"
                   href="http://easyrec.sourceforge.net/wiki/index.php?title=JavaScript_API_v0.98#Receiving_Rankings">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-js.png"/>
                </a>
            </td>
        </tr>
        <tr style="background-color: rgb(239, 239, 239);">
            <td>
                被评分最多次的项目
            </td>
            <td>
                <a target="_blank"
                   href="http://sourceforge.net/p/easyrec/wiki/RankingsAPI/#most-rated-items">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-rest.png"/>
                </a>
                <a target="_blank"
                   href="http://easyrec.sourceforge.net/wiki/index.php?title=JavaScript_API_v0.98#Receiving_Rankings">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-js.png"/>
                </a>
            </td>
        </tr>
        <tr>
            <td>
                被评分最高的项目

            </td>
            <td>
                <a target="_blank"
                   href="http://sourceforge.net/p/easyrec/wiki/RankingsAPI/#best-rated-items">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-rest.png"/>
                </a>
                <a target="_blank"
                   href="http://easyrec.sourceforge.net/wiki/index.php?title=JavaScript_API_v0.98#Receiving_Rankings">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-js.png"/>
                </a>
            </td>
        </tr>
        <tr style="background-color: rgb(239, 239, 239);">
            <td>
                被评分最低的项目
            </td>
            <td>
                <a target="_blank"
                   href="http://sourceforge.net/p/easyrec/wiki/RankingsAPI/#worst-rated-items">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-rest.png"/>
                </a>
                <a target="_blank"
                   href="http://easyrec.sourceforge.net/wiki/index.php?title=JavaScript_API_v0.98#Receiving_Rankings">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-js.png"/>
                </a>
            </td>
        </tr>
    </table>

    <br/>

    <table width="100%">
        <tr>
            <td colspan="2"><span class="headline">分组</span>
                <hr>
            </td>
        </tr>
        <tr style="background-color: rgb(239, 239, 239);">
            <td>
              分组
            </td>
            <td style="width:200px;">
                <a target="_blank"
                   href="http://sourceforge.net/p/easyrec/wiki/ClusterAPI/#clusters">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-rest.png"/>
                </a>
                <a target="_blank"
                   href="http://easyrec.sourceforge.net/wiki/index.php?title=JavaScript_API_v0.98#Receiving_Cluster_Related_Information">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-js.png"/>
                </a>
            </td>
        </tr>

        <tr>
            <td>
                同分组的项目

            </td>
            <td style="width:200px;">
                <a target="_blank"
                   href="http://sourceforge.net/p/easyrec/wiki/ClusterAPI/#items-of-cluster">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-rest.png"/>
                </a>
                <a target="_blank"
                   href="http://easyrec.sourceforge.net/wiki/index.php?title=JavaScript_API_v0.98#Receiving_Cluster_Related_Information">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-js.png"/>
                </a>
            </td>
        </tr>

        <tr style="background-color: rgb(239, 239, 239);">
            <td>
                创建分组

            </td>
            <td style="width:200px;">
                <a target="_blank"
                   href="http://sourceforge.net/p/easyrec/wiki/ClusterAPI/#create-cluster">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-rest.png"/>
                </a>
            </td>
        </tr>
    </table>

    <br/>

    <table width="100%">
        <tr>
            <td colspan="2"><span class="headline">导入API & 其他功能</span>
                <hr>
            </td>
        </tr>
        <tr style="background-color: rgb(239, 239, 239);">
            <td>
                导入规则
            </td>
            <td style="width:200px;">
                <a target="_blank"
                   href="http://sourceforge.net/p/easyrec/wiki/ImportAPI/#import-rule">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-rest.png"/>
                </a>
            </td>
        </tr>
        <tr>
            <td>
                导入/更新项目
            </td>
            <td>
                <a target="_blank"
                   href="http://sourceforge.net/p/easyrec/wiki/ImportAPI/#importupdate-item">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-rest.png"/>
                </a>
            </td>
        </tr>
        <tr style="background-color: rgb(239, 239, 239);">
            <td>
                激活项目
            </td>
            <td>
                <a target="_blank"
                   href="http://sourceforge.net/p/easyrec/wiki/ImportAPI/#set-item-active">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-rest.png"/>
                </a>
            </td>
        </tr>
        <tr>
            <td>
                项目类型
            </td>
            <td style="width:200px;">
                <a target="_blank"
                   href="http://sourceforge.net/p/easyrec/wiki/ImportAPI/#item-types">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-rest.png"/>
                </a>
                <a target="_blank"
                   href="http://easyrec.sourceforge.net/wiki/index.php?title=JavaScript_API_v0.98#Receiving_Itemtypes">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-js.png"/>
                </a>
            </td>
        </tr>
        <tr style="background-color: rgb(239, 239, 239);">
            <td>
               添加项目类型
            </td>
            <td style="width:200px;">
                <a target="_blank"
                   href="http://sourceforge.net/p/easyrec/wiki/ImportAPI/#add-itemtype">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-rest.png"/>
                </a>
            </td>
        </tr>
        <tr>
            <td>
                删除项目类型
            </td>
            <td style="width:200px;">
                <a target="_blank"
                   href="http://sourceforge.net/p/easyrec/wiki/ImportAPI/#delete-itemtype">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-rest.png"/>
                </a>
            </td>
        </tr>
    </table>

    <br/>
    <table width="100%">
        <tr>
            <td colspan="2"><span class="headline">API配置</span>
                <hr>
            </td>
        </tr>
        <tr style="background-color: rgb(239, 239, 239);">
            <td>
                存储
            </td>
            <td style="width:200px;">
                <a target="_blank"
                   href="http://sourceforge.net/p/easyrec/wiki/ProfileAPI/#store">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-rest.png"/>
                </a>
            </td>
        </tr>
        <tr>
            <td>
                存储带有资料的项目
            </td>
            <td style="width:200px;">
                <a target="_blank"
                   href="http://sourceforge.net/p/easyrec/wiki/ProfileAPI/#store-item-with-profile">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-rest.png"/>
                </a>
            </td>
        </tr>
        <tr  style="background-color: rgb(239, 239, 239);">
            <td>
                删除
            </td>
            <td>
                <a target="_blank"
                   href="http://sourceforge.net/p/easyrec/wiki/ProfileAPI/#delete">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-rest.png"/>
                </a>
            </td>
        </tr>
        <tr>
            <td>
                字段删除
            </td>
            <td style="width:200px;">
                <a target="_blank"
                   href="http://sourceforge.net/p/easyrec/wiki/ProfileAPI/#field-delete">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-rest.png"/>
                </a>
            </td>
        </tr>
        <tr style="background-color: rgb(239, 239, 239);">
            <td>
                加载
            </td>
            <td style="width:200px;">
                <a target="_blank"
                   href="http://sourceforge.net/p/easyrec/wiki/ProfileAPI/#load">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-rest.png"/>
                </a>
            </td>
        </tr>
        <tr>
            <td>
               字段加载
            </td>
            <td>
                <a target="_blank"
                   href="http://sourceforge.net/p/easyrec/wiki/ProfileAPI/#field-load">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-rest.png"/>
                </a>
            </td>
        </tr>
        <tr style="background-color: rgb(239, 239, 239);">
            <td>
                字段存储
            </td>
            <td>
                <a target="_blank"
                   href="http://sourceforge.net/p/easyrec/wiki/ProfileAPI/#field-store">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-rest.png"/>
                </a>
            </td>
        </tr>
        <tr>
            <td>
               字段添加
            </td>
            <td>
                <a target="_blank"
                   href="http://sourceforge.net/p/easyrec/wiki/ProfileAPI/#field-push">
                    <img style="" alt="wiki link" src="${webappPath}/img/button_wiki-rest.png"/>
                </a>
            </td>
        </tr>
    </table>

</script>

