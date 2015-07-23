###
  Events State Config - Events List index state of events
###

stateName = 'events'
tabName = 'events'

###Template###
tpl = """
<ion-view view-title="Events Child1">
  <ion-content class="padding">
    <h1>{{ eventsCtrl.name }}</h1>
  </ion-content>
</ion-view>
"""

###Controller###
ctrlName = 'EventsCtrl'
ctrlInstName = s.decapitalize(ctrlName)
Ctrl = ($log, $scope, cfg) ->
  vm = @
  $log.log("Instantiating instance of #{ctrlName}")

  vm.name = ctrlName

  return

###Resolve Functions###
rslvs = {}

###State Config###
stateCfg = {
  name: "tab.#{stateName}"
  url: "/#{stateName}"
  resolve: rslvs
  views: "#{tabName}@tab": {
  template: tpl
  controller: "#{ctrlName} as #{ctrlInstName}"}
}



# ------------------------------Add To App-------------------------------------
gatherNowStates = angular.module('gatherNow.states')
gatherNowStates.controller(ctrlName, Ctrl)
gatherNowStates.config(($stateProvider) -> $stateProvider.state(stateCfg);return;)
