<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="upperbody">
    <h1>上传规则</h1>

    <form method="post" action="upload.form" enctype="multipart/form-data">
        <input type="file" name="file"/>
        <input type="submit"/>
    </form>
    <p> 在<a href="${webappPath}/download/rules_example.csv">这里</a>下载一个样例CSV文件。</p>
</div>

