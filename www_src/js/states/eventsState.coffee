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
<ion-view cache-view="false" view-title="{{ eventsCtrl.headerTitle }}">
  <ion-content class="padding">
    <ion-list>
      <ion-item ng-repeat="item in eventsCtrl.events">
        <a class="item item-thumbnail-left" ui-sref="tab.events.eventDetails({eventId: item._id})"> <!--ng-class="{'item-thumbnail-left': item.image_url}"-->
          <img ng-src="{{item.image_url || 'http://www.gatherthejews.com/wp-content/uploads/2015/03/gather_the_jews_rectangle.png'}}">
          <h2>{{item.title}}</h2>
          <h3>{{item.start_date | amDateFormat:'dddd, MMMM Do YYYY, h:mm:ss a'}}</h3>
        </a>
      </ion-item>

    <ion-infinite-scroll
      on-infinite="#{ctrlInstName}.loadMore()"
      distance="5%">
    </ion-infinite-scroll>

    </ion-list>
  </ion-content>
</ion-view>
"""
###Resolve Functions###
rslvs = {}
rslvs.events = ($http) ->
  return $http.get('https://gather-now-service.herokuapp.com/events')
    .then (resp) -> resp.data


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
    return
  page=1
  vm.loadMore = ->
    page += 1
    $http.get('https://gather-now-service.herokuapp.com/events', params:{'page':page})
      .then (resp) ->
        for newItem in resp.data['_items']
          vm.events.push(newItem)
        $scope.$broadcast('scroll.infiniteScrollComplete')
        return
    return

  activate()
  return

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
gatherNowStates.config(($stateProvider) -> $stateProvider.state("tab.events", stateCfg);return;)
