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
rslvs.events = (eventsService) ->
  return eventsService.loadEvents()

###Controller###
Ctrl = ($log, $scope, cfg, $timeout, events, eventsService) ->
  vm = @
  $log.log("Instantiating instance of MapCtrl")

  vm.name = "MapCtrl"
  vm.headerTitle = "map"

  $scope.onMapInit = (map) ->
    $log.log('map is ready!')
    #map.setCenter(new plugin.google.maps.LatLng(37.422858, -122.085065))

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
