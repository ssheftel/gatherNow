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

###Resolve Functions###
rslvs = {}
rslvs.event = ($http, $stateParams, cfg) ->
  return $http.get(
    "#{cfg.api}/events/#{$stateParams.eventId}"
  ).then (resp) ->
    resp.data

###Controller###
Ctrl = ($log, $scope, cfg, event, $cordovaCalendar) ->
  vm = @
  $log.log("Instantiating instance of EventDetailsCtrl")

  vm.name = "EventDetailsCtrl"
  vm.headerTitle = "Event Details"
  vm.event = event

  # add the event to the users calendar
  vm.addEventToCalendar = ->
    eventCalendarData = {
      title: event.title
      location: (event.address || event.venue)
      notes: event.description
      startDate: moment(event.start_date).toDate()
      endDate: moment(event.end_date).toDate()
    }
    successCb = (localCalendarEventId) ->
      $log.log("event was added to users calendar successfuly! its local calid= #{localCalendarEventId}")
      eventCalendarData
    failureCb = (err) ->
      $log.log("Error adding event to users calendar #{angular.toJson(err)}")
      err
    $cordovaCalendar.createEventInteractively(eventCalendarData).then(successCb, failureCb)


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
  templateUrl: 'js/states/eventDetailsState.html'
  controller: "EventDetailsCtrl as eventDetailsCtrl"}
  cache: false
}



# ------------------------------Add To App-------------------------------------
gatherNowStates = angular.module('gatherNow.states')
gatherNowStates.controller("EventDetailsCtrl", Ctrl)
gatherNowStates.config(($stateProvider) -> $stateProvider.state("tab.events.eventDetails", stateCfg))
