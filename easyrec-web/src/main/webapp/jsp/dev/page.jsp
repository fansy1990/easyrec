<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<jsp:include page="header.jsp"/>
<body>
<div class="fixed">

    <div id="confirm-dialog"></div>

    <!-- modal content -->
    <div id='confirm'>
        <div class='header'><span>确认</span></div>
        <div class='message'></div>
        <div class='buttons'>
            <div class='no simplemodal-close'>否</div>
            <div class='yes'>是</div>
        </div>
    </div>
    <!-- preload the images -->
    <div style='display:none'>
        <img src="${webappPath}/img/confirm/header.gif" alt=""/>
        <img src="${webappPath}/img/confirm/button.gif" alt=""/>
    </div>
    <script type="text/javascript">
        webappPath = '${webappPath}/';
        waitingImage = '<img alt="wait" src="' + webappPath + 'img/wait16.gif"/>';
    </script>
    <script src="${webappPath}/js/dev.js" type="text/javascript"></script>
    <!-- modal content end -->

    <jsp:include page="menu.jsp"/>
    <jsp:include page="${page}.jsp"/>
    <jsp:include page="footer.jsp"/>
</div>
</body>
</html>