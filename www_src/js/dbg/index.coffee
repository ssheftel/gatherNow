###
  debugging script
###

toJson = angular.toJson
window.dbg ?= {}

# -----------------------------------------------------------------------------

###
  log uirouter errors
###
logUiRouterEvents = ($log, $rootScope) ->

  logStateChangeError = (event, toState, toParams, fromState, fromParams) ->
    $log.error("Error Changing state from #{fromState.name}(#{toJson(fromParams)}) -> #{toState.name}(#{toJson(toParams)})")
    return
  logStateNotFoundError = (event, unfoundState, fromState, fromParams) ->
    $log.error("Error: could not find the state #{unfoundState.to}(#{toJson(unfoundState.toParams)})")
    return

  $rootScope.$on('$stateChangeError', logStateChangeError)
  $rootScope.$on('$stateNotFound', logStateNotFoundError)
  return

###
  globlaly expose select angular services on window.dbg
###
globlalyExposeServices = ( $window, $rootScope, $http, $q, $state, $stateParams, $log, $ionicScrollDelegate, eventsService) ->
  dbg = $window.dbg
  dbg.$rootScope = $rootScope
  dbg.$http = $http
  dbg.$q = $q
  dbg.$state = $state
  dbg.$stateParams = $stateParams
  dbg.$log = $log
  dbg.gatherNow = angular.module('gatherNow')
  dbg.$ionicScrollDelegate = $ionicScrollDelegate
  dbg.eventsService = eventsService

# -----------------------------------------------------------------------------
gatherNow = angular.module('gatherNow')
gatherNow.run(logUiRouterEvents)
gatherNow.run(globlalyExposeServices)
