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

<style>
    .tree {
        min-height: 20px;
        padding: 19px;
        margin-bottom: 20px;
        background-color: #fbfbfb;
        border: 1px solid #999;
        -webkit-border-radius: 4px;
        -moz-border-radius: 4px;
        border-radius: 4px;
        -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.05);
        -moz-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.05);
        box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.05)
    }

    .tree li {
        list-style-type: none;
        margin: 0;
        padding: 10px 5px 0 5px;
        position: relative
    }

    .tree li::before, .tree li::after {
        content: '';
        left: -20px;
        position: absolute;
        right: auto
    }

    .tree li::before {
        border-left: 1px solid #999;
        bottom: 50px;
        height: 100%;
        top: 0;
        width: 1px
    }

    .tree li::after {
        border-top: 1px solid #999;
        height: 20px;
        top: 25px;
        width: 25px
    }

    .tree li span {
        -moz-border-radius: 5px;
        -webkit-border-radius: 5px;
        border: 1px solid #999;
        border-radius: 5px;
        display: inline-block;
        padding: 3px 8px;
        text-decoration: none
    }

    .tree li.parent_li>span {
        cursor: pointer
    }

    .tree>ul>li::before, .tree>ul>li::after {
        border: 0
    }

    .tree li:last-child::before {
        height: 30px
    }

    .tree li.parent_li>span:hover, .tree li.parent_li>span:hover+ul li span {
        background: #eee;
        border: 1px solid #94a0b4;
        color: #000
    }
</style>

<div id="document-browser-${currentNode.identifier}" ng-controller="document-browser-ctrl" ng-init="init('document-browser-${currentNode.identifier}')">
    <script type="text/ng-template" id="treeItem.html">
        <span><i ng-class="item.nodeType == 'jnt:folder' ? 'icon-folder-open' : 'icon-file'"></i> {{item.text}}</span>
        <ul>
            <li ng-repeat="item in item.childs" ng-include="'treeItem.html'" ng-init="initTree()"></li>
        </ul>
    </script>

    <div class="tree well">
        <ul>
            <jcr:sql var="sites" sql="SELECT * FROM [jnt:virtualsite] AS s WHERE ISDESCENDANTNODE(s, '/sites') AND s.['j:nodename'] NOT LIKE 'systemsite'"/>
            <c:forEach items="${sites.nodes}" var="site">
                <li>
                    <span><i class="icon-globe"></i> ${site.name}</span>
                    <ul>
                        <jcr:sql var="childFolders" sql="select * from [jnt:folder] where ISCHILDNODE('${site.path}')"/>
                        <c:forEach items="${childFolders.nodes}" var="childFolder">
                            <li ng-init="loadChilds('<c:url value="${url.base}${childFolder.path}.docTree.json" />', '${site.name}_${childFolder.name}')">
                                <div ng-repeat="item in folders['${site.name}_${childFolder.name}']" ng-include="'treeItem.html'">

                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                </li>
            </c:forEach>
        </ul>
    </div>
</div>

<script type="text/javascript">
    // Boostrap app
    angular.bootstrap(document.getElementById("document-browser-${currentNode.identifier}"), ['documentBrowserWidgetApp']);
</script>