###
  Map State Config - Google Map index state
###

stateName = 'map'
tabName = "map" # derived - will be different for nested child states
url = "/map"
ctrlName = "MapCtrl"
ctrlInstName = "mapCtrl"
fullStateName = "tab.map"

###Template###
tpl = """
<ion-view cache-view="false" view-title="{{ mapCtrl.headerTitle }}">
  <ion-content class="padding">
    <h1>{{ mapCtrl.name }}</h1>
  </ion-content>
</ion-view>
"""

###Resolve Functions###
rslvs = {}

###Controller###
Ctrl = ($log, $scope, cfg, $state) ->
  vm = @
  $log.log("Instantiating instance of MapCtrl")

  vm.name = ctrlName
  vm.headerTitle = 'Event Map'
  window.$state = $state

  return

###State Config###
stateCfg = {
  url: url
  resolve: rslvs
  views: "#{tabName}@tab": {
  template: tpl
  controller: "MapCtrl as mapCtrl"}
}



# ------------------------------Add To App-------------------------------------
gatherNowStates = angular.module('gatherNow.states')
gatherNowStates.controller(ctrlName, Ctrl)
gatherNowStates.config(($stateProvider) -> $stateProvider.state(fullStateName, stateCfg);return;)
