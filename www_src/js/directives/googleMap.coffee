###
  directive for creating instance of a cordova google map
  <div google-map onMapReady="someFn(map)"></div>

  derived from https://gist.github.com/vyachkonovalov/a024d398ab6934a59f8d
###

###Directive Name###
googleMapDirectiveName = "googleMap"



###Directive Definition Function###
googleMapDirective = ($log, $timeout) ->
  $log.log("running #{googleMapDirectiveName} directive definition fn")
  d = {} # directive definition object

  d.restrict = 'A'
  d.scope = 'mapReady': '&onMapReady'#TODO: make onMapReady its own directive
  ###TODO: consider moving Map api enhancements (promises) oiut of controller and into into a modelService that wraps plugin.google.maps.Map###
  d.controller = ($log, $scope, $element, $attrs, $location, $q, $timeout) ->
    $log.log("instantiating instance of #{googleMapDirectiveName} directive controller")
    vm = @
    vm._map = null
    vm.mapDeferred = $q.defer()
    vm.mapPromise = vm.mapDeferred.promise

    # resolve the map promise
    vm._triggerMapReady = (map) ->
      $log.log("MAP_READY fired")
      vm.mapDeferred.resolve(map)

    ###
      Initialize the map and calls the _triggerMapReady which resolves the map promise
    ###
    vm.initMap = (elm, mapParams) ->
      $log.log("initializing new google map")

      vm._map = plugin.google.maps.Map.getMap(elm, mapParams)
      vm._map.on(plugin.google.maps.event.MAP_READY, vm._triggerMapReady)
      return vm.mapPromise

    ###
      googleMap.addMarker(markerCfg) -> Promise({marker, map})

      Promise resolved with the value of the marker when marker
      docs for marker props are at https://github.com/wf9a5m75/phonegap-googlemaps-plugin/wiki/Marker
      Added extra markerCfg prop callback which will be called on addition of the marker to the map
      the callback will be invoked in the context of the markerCfg and will be passed a object {marker, map, markerCfg}

      Example

        googleMapCtrl.addMarker({
          title: "Hello GoogleMap for Cordova!"
          position: {lat: 35.13, lng: 137.33}
          callback: ({marker, map, markerCfg}) ->
            map.animateCamera({target: markerCfg.position, tilt:60})
        }).then ({marker, map, markerCfg}) -> marker.showInfoWindow()
    ###
    vm.addMarker = (markerCfg) ->
      deferred = $q.defer()
      promise = deferred.promise
      if markerCfg.callback
        callback = markerCfg.callback
        callbackWrapper = (markerMapAndCfg) ->
          $q.when(callback.bind(markerCfg)(markerMapAndCfg)).then -> markerMapAndCfg
        promise = promise.then callbackWrapper
        delete markerCfg.callback
      vm.mapPromise.then (map) ->
        map.addMarker markerCfg, (marker) -> deferred.resolve({marker, map, markerCfg})
      return promise

    ###
      googleMapCtrl.clearMarkers

      Clears all markers and returns a promise with map instance

      Example
        googleMapCtrl.clearMarkers().then (map) ->
          map.addMarker({title: 'hi', position: {lat: 35.13, lng: 137.33}})

    ###
    vm.clearMarkers = ->
      vm.mapPromise.then (map) ->
        map.clear()
        return map


    return
  d.require = 'googleMap'
  d.link = (scope, element, attr, googleMapCtrl) ->
    $log.log("running #{googleMapDirectiveName} directive link fn")
    ###map config - todo: move to service or make a directive argument###
    mapParams = {
      'mapType': plugin.google.maps.MapTypeId.ROADMAP
      'controls': {
        'compass': true
        'myLocationButton': true
        'indoorPicker': true
      },
      'gestures': {
        'scroll': true
        'tilt': true
        'rotate': true
        'zoom': true
      }
    }

    ###TODO: dont pass controller to callback - move much of controller logic into a Map wrapper service which will enhance the functionality of the Map api###
    googleMapCtrl.initMap(element[0], mapParams).then (map) -> scope.mapReady({map:map, googleMapCtrl:googleMapCtrl})

    destroyCb = ->
      $log.log("#{googleMapDirectiveName} destroyed removing map instance")
      map.remove()
    # Remove map when scope is destroyed
    scope.$on('$destroy',destroyCb)

  return d


# ------------------------------Add To App-------------------------------------
gatherNowDirectives = angular.module('gatherNow.directives')
gatherNowDirectives.directive(googleMapDirectiveName, googleMapDirective)
