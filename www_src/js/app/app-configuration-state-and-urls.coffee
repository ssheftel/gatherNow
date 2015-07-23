###
  Global Configuration for all things URL and State Routing Related
###

# ------------------------------Main Code--------------------------------------

# Constants
defaultUrl = 'tab.events'


###
  Default URL/STATE - Used if url dosn't match any state
    see: https://github.com/Narzerus/angular-permission
###
setDefaultUrl = ($urlRouterProvider) ->
  avoidInfiniteLoop = ($injector, $location) ->
    $state = $injector.get("$state")
    $state.go(defaultUrl)
    return

  $urlRouterProvider.otherwise(avoidInfiniteLoop)
  return

# ------------------------------Add To App-------------------------------------
gatherNow = angular.module('gatherNow')
gatherNow.config(setDefaultUrl)
