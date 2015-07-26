###
  directive for creating instance of a cordova google map
  <div google-map onMapReady="someFn(map)"></div>

  derived from https://gist.github.com/vyachkonovalov/a024d398ab6934a59f8d
###

###Directive Name###
name = "googleMap"



###Directive Definition Function###
drctv = ($log, $timeout) ->
  $log.log("running #{name} directive definition fn")
  d = {} # directive definition object



  d.restrict = 'A'
  d.scope = 'mapReady': '&onMapReady'
  d.link = (scope, element) ->
    $log.log("running #{name} directive link fn")
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
    triggerMapReady = (map) ->
      $log.log("MAP_READY fired")
      scope.mapReady({map:map})


    map = plugin.google.maps.Map.getMap(element[0], mapParams)
    map.on(plugin.google.maps.event.MAP_READY, triggerMapReady)

    destroyCb = ->
      $log.log("#{name} destroyed removing map instance")
      map.remove()
    scope.$on('$destroy',destroyCb)

  return d


# ------------------------------Add To App-------------------------------------
gatherNowDirectives = angular.module('gatherNow.directives')
gatherNowDirectives.directive(name, drctv)
