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
<ion-view cache-view="false" view-title="{{ ::eventDetailsCtrl.event.title }}">

  <ion-content class="padding">
    <div class="list card">

      <!-- Description -->
      <div class="item item-divider text-center">
        Description
      </div>
      <div class="item item-body item-text-wrap">

        <!-- Row -->
        <div class="row responsive-sm">

          <div class="col col-offset-20">
            <img ng-src="{{::eventDetailsCtrl.event.image_url}}" class="full-image">
          </div>

          <div class="col col-20"></div>

        </div>

        <!--Row 2-->
        <div class="row">
          <div class="col">
            <p>{{::eventDetailsCtrl.event.description }}</p>
          </div>
        </div>




      </div>


      <div class="item item-divider text-center">
        Details
      </div>
      <div class="item">

        <!-- Row 1 -->
        <div class="row item-text-wrap" ng-if="eventDetailsCtrl.event.start_date || eventDetailsCtrl.event.end_date">
          <div class="col">
            <dl>
              <dt>Date</dt>
              <dd>{{::eventDetailsCtrl.event.start_date | amDateFormat:'dddd MMMM Do'}}</dd>
            </dl>
          </div>

          <div class="col" ng-if="((eventDetailsCtrl.event.start_date | amDifference : eventDetailsCtrl.event.end_date : 'days') <= 1)">
            <dl>
              <dt ng-if="appCtrl.moment(eventDetailsCtrl.event.start_date).format('HHmmSS') !== '000000' && appCtrl.moment(eventDetailsCtrl.event.end_date).format('HHmmSS') !== '000000'">Time</dt>
              <dd>{{::eventDetailsCtrl.event.start_date | amDateFormat:'h:mm a'}} - {{::eventDetailsCtrl.event.end_date | amDateFormat:'h:mm a'}}</dd>
            </dl>
          </div>
        </div>

        <!-- Row 2 -->
        <div class="row item-text-wrap" ng-if="eventDetailsCtrl.event.venue || eventDetailsCtrl.event.organizer">
          <div class="col" ng-if="eventDetailsCtrl.event.venue">
            <dl>
              <dt>Location</dt>
              <dd>{{eventDetailsCtrl.event.venue}}</dd>
            </dl>
          </div>

          <div class="col" ng-if="eventDetailsCtrl.event.organizer !== ''">
            <dl>
              <dt>Organizer</dt>
              <dd>{{eventDetailsCtrl.event.organizer}}</dd>
            </dl>
          </div>
        </div>

      </div>

    <!--Footer-->
    <div class="item tabs tabs-secondary tabs-icon-left">
      <a ng-if="eventDetailsCtrl.event.facebook_event_url" class="tab-item" ng-href="{{eventDetailsCtrl.event.facebook_event_url}}" ><i class="icon ion-social-facebook"></i>Facebook</a>
      <a class="tab-item" ng-href="{{eventDetailsCtrl.event.url}}" ><i class="icon ion-share"></i>GTJ.com</a>
      <a ng-if="eventDetailsCtrl.event.event_website_url" class="tab-item" ng-href="{{eventDetailsCtrl.event.event_website_url}}" ><i class="icon ion-ios-information-outline"></i><span>More Info</span></a>
      
    </div>

    </div>
  </ion-content>
</ion-view>
"""

###Resolve Functions###
rslvs = {}
rslvs.event = ($http, $stateParams, cfg) ->
  return $http.get(
    "#{cfg.api}/events/#{$stateParams.eventId}"
  ).then (resp) ->
    resp.data

###Controller###
Ctrl = ($log, $scope, cfg, event) ->
  vm = @
  $log.log("Instantiating instance of EventDetailsCtrl")

  vm.name = "EventDetailsCtrl"
  vm.headerTitle = "Event Details"
  vm.event = event


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
  cache: false
}



# ------------------------------Add To App-------------------------------------
gatherNowStates = angular.module('gatherNow.states')
gatherNowStates.controller("EventDetailsCtrl", Ctrl)
gatherNowStates.config(($stateProvider) -> $stateProvider.state("tab.events.eventDetails", stateCfg);return;)
