<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<div class="appendbody">
    <h1>上传插件</h1>
    <br><br>

    <form id="uploadForm" method="post" action="pluginupload.form?tenantId=${tenantId}&operatorId=${operatorId}"
          enctype="multipart/form-data">
        <input type="file" name="file"/><br>
        <a href="#" onclick="$('#uploadForm').submit()" class="button--filled easyrecblue">上传</a>
    </form>
</div>

