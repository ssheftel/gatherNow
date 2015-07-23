###
  EventDetails State Config - EventDetails List index state of eventDetails
  stateName = preferences
  fileName = preferencesState.coffee
  jsFileName = preferencesState.js
  ctrlName = PreferencesCtrl
  ctrlInstsName = preferencesCtrl
  stateNamePrefix = tab
  fullStateName = tab.preferences
  tabName = preferences
  url = /preferences
###

stateName = "preferences"
tabName = "preferences"
url = "/preferences" # derived - but may need to change
ctrlName = "PreferencesCtrl"
ctrlInstName = "preferencesCtrl"
fullStateName = "tab.preferences"

###Template###
tpl = """
<ion-view cache-view="false" view-title="{{ preferencesCtrl.headerTitle }}">
  <ion-content class="padding">
    <h1>{{ preferencesCtrl.name }}</h1>
  </ion-content>
</ion-view>
"""

###Resolve Functions###
rslvs = {}

###Controller###
Ctrl = ($log, $scope, cfg) ->
  vm = @
  $log.log("Instantiating instance of PreferencesCtrl")

  vm.name = "PreferencesCtrl"
  vm.headerTitle = "preferences"


  # activation fn
  vm.activate = ->
    return

  vm.activate() # run activate fn
  return

###State Config###
stateCfg = {
  url: "/preferences"
  resolve: rslvs
  views: "preferences@tab": {
  template: tpl
  controller: "PreferencesCtrl as preferencesCtrl"}
}



# ------------------------------Add To App-------------------------------------
gatherNowStates = angular.module('gatherNow.states')
gatherNowStates.controller("PreferencesCtrl", Ctrl)
gatherNowStates.config(($stateProvider) -> $stateProvider.state("tab.preferences", stateCfg);return;)
