var portalWidgetsZap = angular.module('portalWidgetsZapApp', []);

portalWidgetsZap.directive('portalWidget', function($timeout) {
    return {
        link: function(scope, element, attrs) {
            element.draggable({
                connectToSortable: ".portal_area",
                helper: "clone",
                stop: function(event, ui){

                },
                revert: "invalid"
            });
        }
    };
});

portalWidgetsZap.controller('widgetsCtrl', function ctrl($scope) {
    $scope.widgets = [];
    $scope.desiredWidget = "";
    $scope.query = "";

    $scope.init = function () {
        portal.getWidgetTypes(function (widgets) {
            $scope.$apply(function () {
                $scope.widgets = widgets;
            });
        });
    };

    $scope.search = function (widget) {
        return !!((widget.name.toLowerCase().indexOf($scope.query.toLowerCase() || '') !== -1 || widget.displayableName.toLowerCase().indexOf($scope.query.toLowerCase() || '') !== -1));
    };
});