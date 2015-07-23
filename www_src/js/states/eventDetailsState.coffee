###
  EventDetails State Config - EventDetails List index state of eventDetails
###

stateName = 'eventDetails'
tabName = 'events' # name of the tab from ion-nav-view name property - same as ui-view

###Derived and Defaulted Variables###
parentStates = ['tab', 'events'] # should be '' if no parent
url = "/:eventId" # derived - but may need to change
ctrlName = "#{s.capitalize(stateName)}Ctrl"# 'EventDetailsCtrl'
ctrlInstName = s.decapitalize(ctrlName)
stateNamePrefix = parentStates.join('.')
fullStateName = "#{stateNamePrefix}.#{stateName}"

###Template###
tpl = """
<ion-view view-title="{{ #{ctrlInstName}.headerTitle }}">
  <ion-content class="padding">
    <h1>bob{{ #{ctrlInstName}.name }}</h1>
    <a ui-sref=".eventSubDetails">to details</a>
  </ion-content>
</ion-view>
"""

###Resolve Functions###
rslvs = {}

###Controller###
Ctrl = ($log, $scope, cfg, $ionicNavBarDelegate) ->
  vm = @
  $log.log("Instantiating instance of #{ctrlName}")

  vm.name = ctrlName
  vm.headerTitle = stateName

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
