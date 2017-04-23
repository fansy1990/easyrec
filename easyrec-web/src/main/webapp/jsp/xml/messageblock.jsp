<?xml version="1.0" encoding="UTF-8"?>
<%@ page contentType="text/xml; charset=UTF-8" %>
<%@ page language="java" session="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<easyrec>
    <action>${action}</action>
    <c:forEach var="message" items="${messages}"><${title} code="${message.code}" message="${message.description}"/>
    </c:forEach>
    <c:if test="${token!=null}">
        <token>${token}</token>
    </c:if>
</easyrec>