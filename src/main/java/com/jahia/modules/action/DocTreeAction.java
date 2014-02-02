package com.jahia.modules.action;

import java.util.List;
import java.util.Map;
import javax.jcr.RepositoryException;
import javax.jcr.query.QueryManager;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.jahia.bin.Action;
import org.jahia.bin.ActionResult;
import org.jahia.bin.Render;
import org.jahia.services.content.JCRContentUtils;
import org.jahia.services.content.JCRNodeWrapper;
import org.jahia.services.content.JCRSessionWrapper;
import org.jahia.services.render.RenderContext;
import org.jahia.services.render.Resource;
import org.jahia.services.render.URLResolver;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Created by kevan on 31/01/14.
 */
public class DocTreeAction extends Action{
	private static Logger logger = LoggerFactory.getLogger(DocTreeAction.class);

	@Override
	public ActionResult doExecute(HttpServletRequest req, RenderContext renderContext, Resource resource, JCRSessionWrapper session, Map<String, List<String>> parameters, URLResolver urlResolver) throws Exception {
		String path = "";
		if (parameters.containsKey("path")) {
			path = parameters.get("path").get(0);
		}
		return new ActionResult(HttpServletResponse.SC_OK, null, buildTree(session.getNode(path)));
	}

	private JSONObject buildTree(JCRNodeWrapper node) throws JSONException, RepositoryException {
		JSONObject item = new JSONObject();
		item.put("title", node.getDisplayableName());
		item.put("nodeType", node.getPrimaryNodeTypeName());
		item.put("url", node.getUrl());
		item.put("path", node.getPath());

		JSONArray itemChilds = new JSONArray();
		List<JCRNodeWrapper> childs = JCRContentUtils.getChildrenOfType(node, "jnt:virtualsite,jnt:folder,jnt:file");
		if(childs.size() > 0){
			for(JCRNodeWrapper child : childs){
				if(child.getPrimaryNodeTypeName().equals("jnt:virtualsite") && child.getName().equals("systemsite")){
					continue;
				}
				itemChilds.put(buildTree(child));
			}
		}
		item.put("childs", itemChilds);
		return item;
	}
}
