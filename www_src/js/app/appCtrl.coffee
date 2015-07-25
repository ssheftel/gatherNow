###
  AppCtrl - Used in similar manner as $rootScope
###

# ------------------------------Main Code--------------------------------------

ctrlName = 'AppCtrl'
ctrlInstName = s.decapitalize(ctrlName)

AppCtrl = ($log, $scope, $rootScope, $state, $stateParams, $window, $cordovaInAppBrowser) ->
  vm = @
  $log.log("Instantiating instance of #{ctrlName}")

  vm.name = ctrlName
  vm.$state = $state
  vm.$stateParams = $stateParams
  vm._ = $window._
  vm.moment = $window.moment
  vm.s = $window.s
  vm.$cordovaInAppBrowser = $cordovaInAppBrowser
  #$rootScope.appCtrl = vm
  return

# ------------------------------Add To App-------------------------------------
gatherNow = angular.module('gatherNow')
gatherNow.controller(ctrlName, AppCtrl)
