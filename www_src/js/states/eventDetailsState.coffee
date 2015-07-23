###
  EventDetails State Config - EventDetails List index state of eventDetails
  stateName = eventDetails
  fileName = eventDetailsState.coffee
  jsFileName = eventDetailsState.js
  ctrlName = EventDetailsCtrl
  ctrlInstsName = eventDetailsCtrl
  stateNamePrefix = tab.events
  fullStateName = tab.events.eventDetails
  tabName = events
  url = /:eventId
###

stateName = "eventDetails"
tabName = "events"
url = "/:eventId" # derived - but may need to change
ctrlName = "EventDetailsCtrl"
ctrlInstName = "eventDetailsCtrl"
fullStateName = "tab.events.eventDetails"

###Template###
tpl = """
<ion-view cache-view="false" view-title="{{ eventDetailsCtrl.headerTitle }}">
  <ion-content class="padding">
    <h1>{{ eventDetailsCtrl.name }}</h1>
  </ion-content>
</ion-view>
"""

###Resolve Functions###
rslvs = {}

###Controller###
Ctrl = ($log, $scope, cfg) ->
  vm = @
  $log.log("Instantiating instance of EventDetailsCtrl")

  vm.name = "EventDetailsCtrl"
  vm.headerTitle = "eventDetails"


  # activation fn
  vm.activate = ->
    return

  vm.activate() # run activate fn
  return

###State Config###
stateCfg = {
  url: "/:eventId"
  resolve: rslvs
  views: "events@tab": {
  template: tpl
  controller: "EventDetailsCtrl as eventDetailsCtrl"}
}



# ------------------------------Add To App-------------------------------------
gatherNowStates = angular.module('gatherNow.states')
gatherNowStates.controller("EventDetailsCtrl", Ctrl)
gatherNowStates.config(($stateProvider) -> $stateProvider.state("tab.events.eventDetails", stateCfg);return;)
