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

<p>
    请选择适合您用于集成华联云谷推荐平台的技术的相应选项卡
</p>

<div id="followingStepsTabs">
    <ul>
        <li><a href="#plugins"><span>插件</span></a></li>
        <li><a href="#jsApi"><span>JS API</span></a></li>
        <li><a href="#restApi"><span>REST API</span></a></li>
    </ul>

    <div id="plugins">
        <p>如果您使用插件或者组件集成easyrec到您的网站，请您开始时一定仔细阅读文档。每个插件最有
            可能会要求您在应用程序中配置以下三件事情：
        </p>


        <dl>
            <dt>easyrec Api 密钥:</dt>
            <dd>${apiKey}</dd>

            <dt>easyrec 租户ID:</dt>
            <dd class="tenantId"></dd>

            <dt>easyrec URL:</dt>
            <dd>${extendedWebappPath}/</dd>
        </dl>


    </div>

    <div id="jsApi">
        <p>
             <easyrec:wikiLink pageName="JavaScript_API_v0.98" name="JavaScript API"/>
            JavaScript API是一种非常易于将easyrec集成到您的网站的方式。
            这个方式在REST API上面使用了一个简单的JS层
            您需要在您的网站上添加如下代码，以此来开始发送动作并接收推荐：

        </p>

        <code>
            &lt;script src="${extendedWebappPath}/api-js/easyrec.js" type="text/javascript"&gt;&lt;/script&gt;<br>

            &lt;script type="text/javascript"&gt;<br>
            &nbsp;&nbsp;&nbsp;var apiKey = "${apiKey}";<br>
            &nbsp;&nbsp;&nbsp;var tenantId = "<span class="tenantId"></span>";<br>
            &lt;/script&gt;
        </code>
        
        <p>     这个Javascript API会被当作私有的，并且不支持所有的API函数。可以考虑使用我们的
             <a href="https://sourceforge.net/p/easyrec/wiki/API/#angularjs-service" target="_blank">AngularJS service</a>
            作为替代。
        </p>

    </div>

    <div id="restApi">
        <p>
            <a href="https://sourceforge.net/p/easyrec/wiki/API/" target="_blank">REST API</a>
            可以在客户端代码中被使用（和javascript API的情况类似），也可以在服务器端使用。
            访问API需要以下数据 ：
        </p>

        <dl>
            <dt>easyrec Api密钥:</dt>
            <dd>${apiKey}</dd>

            <dt>easyrec 租户ID:</dt>
            <dd class="tenantId"></dd>

            <dt>easyrec URL:</dt>
            <dd>${extendedWebappPath}/</dd>
        </dl>
    </div>

</div>

<script type="text/javascript">
    $(document).ready(function() {
        $("#followingStepsTabs").tabs({ selected: 0 });
    });
</script>