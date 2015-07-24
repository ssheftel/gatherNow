###
  EventDetails State Config - EventDetails List index state of eventDetails
  stateName = events
  fileName = eventsState.coffee
  jsFileName = eventsState.js
  ctrlName = EventsCtrl
  ctrlInstsName = eventsCtrl
  stateNamePrefix = tab
  fullStateName = tab.events
  tabName = events
  url = /events
###

stateName = "events"
tabName = "events"
url = "/events" # derived - but may need to change
ctrlName = "EventsCtrl"
ctrlInstName = "eventsCtrl"
fullStateName = "tab.events"

###Template###
tpl = """
<ion-view view-title="{{ eventsCtrl.headerTitle }}">
  <ion-content class="padding">
    <ion-list>
      <ion-item class="item-avatar item-icon-right item-text-wrap" ng-repeat="item in eventsCtrl.events" ui-sref="tab.events.eventDetails({eventId: item._id})">

          <img ng-src="{{item.image_url || 'http://www.gatherthejews.com/wp-content/uploads/2015/03/gather_the_jews_rectangle.png'}}">
          <i class="icon ion-chevron-right"></i>

          <h2>{{item.title}}</h2>
          <p ng-if="item.venue">{{item.venue}}</p>
          <p>{{item.start_date | amDateFormat:'ddd. MMM Do'}} from {{item.start_date | amDateFormat:'h:mm a'}} - {{item.end_date | amDateFormat:'h:mm a'}}</p>


      </ion-item>
    </ion-list>
  </ion-content>
</ion-view>
"""
###Resolve Functions###
rslvs = {}
rslvs.events = ($http, cfg) ->
  config = params:
    max_results: 200
    sort: 'start_date'
    where: """{"start_date": {"$gte": "#{new Date().toISOString()}"}}"""
  return $http.get(
    "#{cfg.api}/events", config
    ).then (resp) ->
      resp.data


###Controller###
Ctrl = ($log, $scope, cfg, $state, events, $http) ->
  vm = @
  $log.log("Instantiating instance of #{ctrlName}")

  vm.name = ctrlName
  vm.headerTitle = 'Upcoming Events'
  vm.events = events._items
  window.$state = $state
  activate = ->
    $log.log('activating!')



  activate()


###State Config###
stateCfg = {
  url: "/events"
  resolve: rslvs
  views: "events@tab": {
  template: tpl
  controller: "EventsCtrl as eventsCtrl"}
}



# ------------------------------Add To App-------------------------------------
gatherNowStates = angular.module('gatherNow.states')
gatherNowStates.controller("EventsCtrl", Ctrl)
gatherNowStates.config(($stateProvider) -> $stateProvider.state("tab.events", stateCfg))
