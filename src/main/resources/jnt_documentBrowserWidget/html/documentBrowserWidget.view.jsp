<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>

<template:addResources type="javascript" resources="jquery.min.js"/>
<template:addResources type="javascript" resources="angular.min.js"/>
<template:addResources type="javascript" resources="app/documentBrowserWidget.js"/>
<template:addResources type="css" resources="app/docBrowserWidget.css"/>

<div class="docBrowserWidget" id="document-browser-${currentNode.identifier}"
	 ng-controller="document-browser-ctrl"
	 ng-init="init('document-browser-${currentNode.identifier}', '<c:url value="${url.base}/sites"/>')">

	<script type="text/ng-template" id="treeItem.html">
		<span><i ng-class="getIcon(item)"></i> {{item.title}}</span>
				<a ng-if="isFile(item)" href="{{item.url}}" download><i class="icon-download-alt"></i>download</a>
		<ul>
			<li ng-repeat="item in item.childs" ng-include="'treeItem.html'" ng-init="initTree()">
			</li>
		</ul>
	</script>

	<div class="tree well">
		<ul>
			<li ng-include="'treeItem.html'">

			</li>
		</ul>
	</div>
</div>

<script type="text/javascript">
	// Boostrap app
	angular.bootstrap(document.getElementById("document-browser-${currentNode.identifier}"), ['documentBrowserWidgetApp']);
</script>