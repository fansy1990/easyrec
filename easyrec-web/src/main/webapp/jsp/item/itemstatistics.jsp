<%@ page language="java" session="false" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8"%>

<p>这里您可以看到当前项目的一些统计数据。
</p>

<table width="100%">
    <tr>
        <td width="140px"><strong>初次操作：</strong></td>
        <td>${itemDetails.minActionTime}</td>
    </tr>
    <tr>
        <td><strong>最后操作：</strong></td>
        <td>${itemDetails.maxActionTime}</td>
    </tr>
    <tr>
        <td><strong>总操作数：</strong></td>
        <td>${itemDetails.actions}</td>
    </tr>
    <tr>
        <td><strong>总用户数：</strong></td>
        <td>${itemDetails.users}</td>
    </tr>
</table>