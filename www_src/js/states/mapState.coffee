###
  EventDetails State Config - EventDetails List index state of eventDetails
  stateName = map
  fileName = mapState.coffee
  jsFileName = mapState.js
  ctrlName = MapCtrl
  ctrlInstsName = mapCtrl
  stateNamePrefix = tab
  fullStateName = tab.map
  tabName = map
  url = /map
###

stateName = "map"
tabName = "map"
url = "/map" # derived - but may need to change
ctrlName = "MapCtrl"
ctrlInstName = "mapCtrl"
fullStateName = "tab.map"

###Resolve Functions###
rslvs = {}

###Controller###
Ctrl = ($log, $scope, cfg) ->
  vm = @
  $log.log("Instantiating instance of MapCtrl")

  vm.name = "MapCtrl"
  vm.headerTitle = "map"


  # activation fn
  vm.activate = ->
    return

  vm.activate() # run activate fn
  return

###State Config###
stateCfg = {
  url: "/map"
  resolve: rslvs
  views: "map@tab": {
  templateUrl: 'js/states/map.html'
  controller: "MapCtrl as mapCtrl"}
  cache: false
}



# ------------------------------Add To App-------------------------------------
gatherNowStates = angular.module('gatherNow.states')
gatherNowStates.controller("MapCtrl", Ctrl)
gatherNowStates.config(($stateProvider) -> $stateProvider.state("tab.map", stateCfg))
