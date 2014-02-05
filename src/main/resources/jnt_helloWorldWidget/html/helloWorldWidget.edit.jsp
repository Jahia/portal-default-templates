<%@ page import="org.jahia.modules.portal.PortalConstants" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="portal" uri="http://www.jahia.org/tags/portalLib" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>
<%--@elvariable id="skin" type="org.jahia.services.render.View"--%>

<c:set var="portalTabNT" value="<%= PortalConstants.JNT_PORTAL_TAB %>"/>
<c:set var="portalMix" value="<%= PortalConstants.JMIX_PORTAL %>"/>
<c:set var="portalWidgetMix" value="<%= PortalConstants.JMIX_PORTAL_WIDGET %>"/>
<c:set var="widgetSkinProp" value="<%= PortalConstants.J_WIDGET_SKIN %>"/>
<c:set var="portalTabNode" value="${jcr:getParentOfType(currentNode, portalTabNT)}"/>
<c:set var="portalNode" value="${jcr:getParentOfType(currentNode, portalMix)}"/>
<c:set var="currentWidgetSkin" value="${currentNode.properties[widgetSkinProp].string}"/>

<template:addResources type="css" resources="portal/commonsWidget.css"/>

<div class="widget-edit">
    <h2>
        Edit: ${currentNode.displayableName}
    </h2>

    <div class="box-1">
        <form action="<c:url value="${url.base}${currentNode.path}"/>" method="POST">
            <input type="hidden" name="jcrRedirectTo" value="<c:url value="${url.base}${portalTabNode.path}"/>">
            <input type="hidden" name="jcrNodeType" value="${currentNode.primaryNodeTypeName}"/>

            <div class="row-fluid">
                <div class="span12">
                    <label>
                        <span><fmt:message key="title"/>:</span>
                        <input type="text" name="jcr:title" value="${currentNode.displayableName}"/>
                    </label>
                </div>
            </div>

            <div class="row-fluid">
                <div class="span12">
                    <label>
                        <span>skin:</span>
                        <select name="j:widgetSkin">
                            <c:forEach items="${portal:getViewsSet(portalWidgetMix, portalNode)}" var="skin">
                                <option value="${skin.key}" ${currentWidgetSkin == skin.key ? 'selected="selected"' : ''}>
                                    <fmt:message key="${skin.displayName}"/></option>
                            </c:forEach>
                        </select>
                    </label>
                </div>
            </div>

            <div class="row-fluid">
                <div class="span12">
                    <button class="btn btn-primary" type="submit">
                        <fmt:message key="save"/>
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>