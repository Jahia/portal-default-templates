<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>
<%--@elvariable id="skin" type="org.jahia.services.render.View"--%>

<c:set var="nodeTypes" value="jnt:folder,jnt:file"/>

<json:object>
    <json:property name="id" value="${currentNode.identifier}"/>
    <json:property name="path" value="${currentNode.path}"/>
    <c:if test="${jcr:isNodeType(currentNode, 'mix:title')}">
        <jcr:nodeProperty name="jcr:title" node="${currentNode}" var="title"/>
    </c:if>
    <json:property name="text" value="${not empty title ? title.string : currentNode.name}"/>
    <json:property name="expanded" value="true"/>
    <json:property name="nodeType" value="${currentNode.primaryNodeTypeName}"/>

    <json:array name="childs" items="${jcr:getChildrenOfType(currentNode, nodeTypes)}" var="childNode">
        <template:module node="${childNode}" templateType="json" editable="false" view="docTree"/>
    </json:array>
</json:object>