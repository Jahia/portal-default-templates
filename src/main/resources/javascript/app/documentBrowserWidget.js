var documentBrowserWidget = angular.module('documentBrowserWidgetApp', []);

documentBrowserWidget.controller('document-browser-ctrl', function ctrl($scope) {
	$scope.item = "";
	$scope.htmlId = "";

	$scope.getIcon = function(item){
		var nodetype = item.nodeType;
		if(nodetype == "jnt:virtualsitesFolder"){
			return "icon-home";
		}else if(nodetype == "jnt:virtualsite"){
			return "icon-globe";
		}else if(nodetype == "jnt:folder"){
			return "icon-folder-open";
		}else if(nodetype == "jnt:file"){
			return "icon-file";
		}
	};

	$scope.isFile = function(item){
		return item.nodeType == "jnt:file";
	};

	$scope.init = function (id, url) {
		$scope.htmlId = id;

		$.ajax({
			type: "GET",
			dataType: "json",
			url: url + ".docTree.do"
		}).done(function (data) {
				$scope.$apply(function () {
					$scope.item = data;
				});
			});
	};

	$scope.initTree = function () {
		$('#' + $scope.htmlId + ' .tree li:has(ul)').addClass('parent_li').find(' > span').attr('title', 'Collapse this branch');
		$('#' + $scope.htmlId + ' .tree li.parent_li > span').off("click");
		$('#' + $scope.htmlId + ' .tree li.parent_li > span').on('click', function (e) {
			var children = $(this).parent('li.parent_li').find(' > ul > li');
			if (children.is(":visible")) {
				children.hide('fast');
				$(this).attr('title', 'Expand this branch').find(' > i');
			} else {
				children.show('fast');
				$(this).attr('title', 'Collapse this branch').find(' > i');
			}
			e.stopPropagation();
		});
	}
});

documentBrowserWidget.controller('document-browser-edit-ctrl', function test($scope) {
	$scope.widget = {};

	$scope.init = function (widgetId) {
		$scope.widget = portal.getCurrentWidget(widgetId);
	};

	$scope.update = function (form) {
		$scope.widget.performUpdate(form, function (data) {
			$scope.widget.load();
		});
	};

	$scope.cancel = function () {
		$scope.widget.load();
	};
});
