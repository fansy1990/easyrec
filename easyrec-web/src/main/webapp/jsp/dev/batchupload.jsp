<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<div class="appendbody">
    <h1>导入数据</h1>
    <div style="padding-left: 50px">
    <br>
        <h3>数据类型格式要求：</h3>
        <p>ITEM:输入数据需满足：ItemIId, ItemDescription, ItemUrl, ItemImageUrl
            <br> 数据采用逗号分割,ItemDescription,ItemUrl, ItemImageUrl可以为空，但是不能省略逗号；
        </p>
        <p>Action(View/Rate):
            输入数据需要：<br>
            userId, itemId, itemType, itemDescription,
            itemUrl, itemImageUrl, rateValue/viewValue, actionDate, actionInfo<br>
            其中，itemId,itemType 不能为空；actionDate如果存在(不存在则为当前时间)，其格式需要为 "yyyy-MM-dd HH:mm:ss"
        </p>
    <br>
    <form id="uploadForm" method="post" action="batchupload.form?tenantId=${tenantId}&operatorId=${operatorId}"
          enctype="multipart/form-data">
        <input type="file" name="file"/><br>
        选择数据类型：
        <select name="fileType">
            <option value="ITEM" selected="true">ITEM</option>
            <option value="BUY">Buy</option>
            <option value="RATE">Rate</option>
            <option value="VIEW">View</option>
        </select>
        <br>
        <a href="#" onclick="$('#uploadForm').submit()" class="button--filled easyrecblue">导入</a>
    </form>
    </div>
</div>

