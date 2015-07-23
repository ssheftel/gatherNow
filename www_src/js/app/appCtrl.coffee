###
  AppCtrl - Used in similar manner as $rootScope
###

# ------------------------------Main Code--------------------------------------

ctrlName = 'AppCtrl'
ctrlInstName = s.decapitalize(ctrlName)

AppCtrl = ($log, $scope, $rootScope, $state, $stateParams) ->
  vm = @
  $log.log("Instantiating instance of #{ctrlName}")

  vm.name = ctrlName
  vm.$state = $state
  vm.$stateParams = $stateParams
  return

# ------------------------------Add To App-------------------------------------
gatherNow = angular.module('gatherNow')
gatherNow.controller(ctrlName, AppCtrl)
