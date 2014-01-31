var documentBrowserWidget = angular.module('documentBrowserWidgetApp', []);

documentBrowserWidget.controller('document-browser-ctrl', function ctrl($scope) {
    $scope.folders = [];
    $scope.htmlId = "";

    $scope.init = function (id) {
        $scope.htmlId = id;
    };

    $scope.loadChilds = function(url, key) {
        $.ajax({
            type: "GET",
            dataType: "json",
            url: url
        }).done(function (data) {
                $scope.$apply(function () {
                    console.log([data]);
                    $scope.folders[key] = [data];
                    setTimeout($scope.initTree(), 40);
                });
            });
    };

    $scope.initTree = function(){
        $(function () {
            $('#' + $scope.htmlId + ' .tree li:has(ul)').addClass('parent_li').find(' > span').attr('title', 'Collapse this branch');
            $('#' + $scope.htmlId + ' .tree li.parent_li > span').off("click");
            $('#' + $scope.htmlId + ' .tree li.parent_li > span').on('click', function (e) {
                var children = $(this).parent('li.parent_li').find(' > ul > li');
                if (children.is(":visible")) {
                    children.hide('fast');
                    $(this).attr('title', 'Expand this branch').find(' > i').addClass('icon-plus-sign').removeClass('icon-minus-sign');
                } else {
                    children.show('fast');
                    $(this).attr('title', 'Collapse this branch').find(' > i').addClass('icon-minus-sign').removeClass('icon-plus-sign');
                }
                e.stopPropagation();
            });
        });
    }
});

documentBrowserWidget.controller('document-browser-edit-ctrl', function test($scope) {
    $scope.widget = {};

    $scope.init = function(widgetId){
        $scope.widget = portal.getCurrentWidget(widgetId);
    };

    $scope.update = function(form){
        $scope.widget.performUpdate(form, function(data){
            $scope.widget.load();
        });
    };

    $scope.cancel = function(){
        $scope.widget.load();
    };
});
