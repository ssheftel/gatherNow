###
  From: https://gist.github.com/ramanan12345/943bfed82fed586af3e5
###
###Directive Name###
tickListDirectiveName = "tickList"

###Directive Controller###
tickListController = ($scope) ->
  @scope = $scope
  items = $scope.items = []

  @addItem = (item) ->
    items.push(item)

  @selectItem = (item) ->
    applyFn = ->
      if $scope.multiple
        item.$select(!item.model.selected)
      else
        for itm in items
          itm.$select(false)
        item.$select(true)
    $scope.$apply(applyFn)

###Directive Definition Function###
tickListDirective = ($log) ->
  $log.log("running #{tickListDirectiveName} directive definition fn")
  d = {}

  d.restrict = 'E'
  d.transclude = true
  d.template = '<ul class="list" ng-transclude></ul>'
  d.controller = tickListController
  d.scope =
    multiple: '@'
    selectedIcon: '@'
    $onChange: '&onChange'

  return d

###------------------------------------------###
tickListItemDirectiveName = "tickListItem"

###Directive Definition Function###
tickListItemDirective = ($log, $ionicGesture) ->
  $log.log("running #{tickListItemDirectiveName} directive definition fn")
  d = {}

  d.restrict = 'E'
  d.require = '^tickList'
  d.transclude = true
  d.template = '<li class="item item-icon-right" ><div ng-transclude></div><i ng-show="model.selected" class="icon"></i></li>'
  d.scope =
    selected: '@'
    selectedIcon: '@'
    model: '='
    $onChange: '&onChange'
  d.link = (scope, element, attrs, tickListCtrl) ->
    $log.log("running #{tickListItemDirectiveName} link fn")
    tap = -> tickListCtrl.selectItem(scope)

    scope.$select = (value) ->
      val = scope.model.selected
      scope.selected = value
      scope.model.selected = value if scope.model
      scope.$onChange(scope.model) if val != value
      return

    scope.model = {selected: scope.selected == 'true'} if not scope.model
    element.find('i').addClass(scope.selectedIcon || tickListCtrl.scope.selectedIcon || 'ion-checkmark')
    tickListCtrl.addItem(scope)
    $ionicGesture.on('tap', tap, element)
    return

  return d

# ------------------------------Add To App-------------------------------------
gatherNowDirectives = angular.module('gatherNow.directives')
gatherNowDirectives.directive(tickListDirectiveName, tickListDirective)
gatherNowDirectives.directive(tickListItemDirectiveName, tickListItemDirective)
