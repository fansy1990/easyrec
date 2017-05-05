<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<div class="appendbody">
    <h1>导入数据</h1>
    <br><br>

    <form id="uploadForm" method="post" action="batchupload.form?tenantId=${tenantId}&operatorId=${operatorId}"
          enctype="multipart/form-data">
        <input type="file" name="file"/><br>
        选择数据类型：
        <select id="fileType">
            <option value="ITEM" selected="true">ITEM</option>
            <option value="ACTION">Action(Buy/Rate/View)</option>
        </select>
        <br>
        <a href="#" onclick="$('#uploadForm').submit()" class="button--filled easyrecblue">导入</a>
    </form>
</div>

