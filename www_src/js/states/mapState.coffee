###
  Map State Config - Google Map index state
###

stateName = 'map'
tabName = "#{stateName}" # derived - will be different for nested child states

###Derived and Defaulted Variables###
parentStates = ['tab'] # should be '' if no parent
url = "/#{stateName}" # derived - but may need to change
ctrlName = "#{s.capitalize(stateName)}Ctrl"# 'EventDetailsCtrl'
ctrlInstName = s.decapitalize(ctrlName)
stateNamePrefix = parentStates.join('.')
fullStateName = "#{stateNamePrefix}.#{stateName}"

###Template###
tpl = """
<ion-view view-title="{{ #{ctrlInstName}.headerTitle }}">
  <ion-content class="padding">
    <h1>{{ #{ctrlInstName}.name }}</h1>
  </ion-content>
</ion-view>
"""

###Resolve Functions###
rslvs = {}

###Controller###
Ctrl = ($log, $scope, cfg, $state) ->
  vm = @
  $log.log("Instantiating instance of #{ctrlName}")

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
  controller: "#{ctrlName} as #{ctrlInstName}"}
}



# ------------------------------Add To App-------------------------------------
gatherNowStates = angular.module('gatherNow.states')
gatherNowStates.controller(ctrlName, Ctrl)
gatherNowStates.config(($stateProvider) -> $stateProvider.state(fullStateName, stateCfg);return;)
