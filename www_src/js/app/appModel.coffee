###
  Global Application Data Model
###

# ------------------------------Main Code--------------------------------------

modelName = 'appModel'

appModelFactory = ($log) ->
  m = {}
  $log.log("Instantiating instance of #{modelName}")

  return m

# ------------------------------Add To App-------------------------------------
gatherNow = angular.module('gatherNow')
gatherNow.factory(modelName, appModelFactory)
