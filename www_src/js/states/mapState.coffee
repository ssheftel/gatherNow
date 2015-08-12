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
Ctrl = ($log, $scope, cfg, $timeout, eventsService, $q) ->
  vm = @
  $log.log("Instantiating instance of MapCtrl")

  vm.name = "MapCtrl"
  vm.headerTitle = "Map"
  vm.eventsFilter = '30DAYS' # '1DAYS' | '7DAYS' | '30DAYS'
  vm.events = []
  vm.map = null
  vm.googleMapCtrl = null # TODO: remove and create service

  #TODO: remove ctrl from params and wrap map api improvements in a serviceModel
  vm.onMapInit = (map, googleMapCtrl) ->
    $log.log('map is ready!')
    vm.map = map
    vm.googleMapCtrl = googleMapCtrl
    #map.setCenter(new plugin.google.maps.LatLng(37.422858, -122.085065))
    #for event in events
    #  continue if not event.latlng
    #  googleMapCtrl.addMarker({
    #    title: "#{event.title} @ #{event.venue}"
    #    snippet: "#{event.start_moment.format('ddd. MMM Do')} from #{event.start_moment.format('h:mm a')} - #{event.end_moment.format('h:mm a')}"
    #    position: event.latlng
    #    icon: 'img/map_icons/hellow_blue_pin.png'
    #    styles: {'text-align': 'center'}
    #  })

    #setup eventsFilter watch
    $scope.$watch(
      -> vm.eventsFilter
      -> vm.updateMapMarkers()
    )

  # Move to service?
  vm.makeMarker = (event) ->
    markerConfig = {
      title: "#{event.title} @ #{event.venue}"
      snippet: "#{event.start_moment.format('ddd. MMM Do')} from #{event.start_moment.format('h:mm a')} - #{event.end_moment.format('h:mm a')}"
      position: event.latlng
      icon: 'img/map_icons/hellow_blue_pin.png'
      styles: {'text-align': 'center'}
      callback: ({marker, map, markerCfg}) ->
        $log.log("marker info clicked for event = #{event._id}")
        marker.addEventListener(plugin.google.maps.event.INFO_CLICK, -> $state.go('tab.map.eventDetails', {eventId: event._id}))
    }
    return markerConfig

  vm.addEventMarkers = (events) ->
    markerPromises = []
    for event in events
      continue if not event.latlng
      markerPromise = vm.googleMapCtrl.addMarker(vm.makeMarker(event))
      markerPromises.push markerPromise
    $q.all(markerPromises).then()

  vm.updateMapMarkers = ->
    $log.log("updating the map markers #{vm.eventsFilter}")
    vm.map.clear()
    # TODO this works but it is should be optimised
    # Clear the vm.events array
    while vm.events.length > 0
      vm.events.pop()
    newEventsSubset = eventsService.filter(vm.eventsFilter)
    for e in newEventsSubset
      vm.events.push e
    $log.log("#{vm.events.length}")
    vm.addEventMarkers(vm.events).then ->
      vm.map.getMyLocation (location) ->
        vm.map.animateCamera {zoom: 12, target:{lat: location.latLng.lat, lng: location.latLng.lng}, duration: 2000}
    return




  # activation fn
  vm.activate = ->
    return

  # run activate fn
  do vm.activate

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
