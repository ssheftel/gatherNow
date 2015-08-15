###
  EventDetails State Config - EventDetails List index state of eventDetails
  stateName = preferencesFavOrgs
  fileName = preferencesFavOrgsState.coffee
  jsFileName = preferencesFavOrgsState.js
  ctrlName = PreferencesFavOrgsCtrl
  ctrlInstsName = preferencesFavOrgsCtrl
  stateNamePrefix = tab.preferences
  fullStateName = tab.preferences.preferencesFavOrgs
  tabName = preferences
  url = /favOrgs
###

stateName = "preferencesFavOrgs"
tabName = "preferences"
url = "/favOrgs" # derived - but may need to change
ctrlName = "PreferencesFavOrgsCtrl"
ctrlInstName = "preferencesFavOrgsCtrl"
fullStateName = "tab.preferences.preferencesFavOrgs"

###Resolve Functions###
rslvs = {}
rslvs.favsOrgs = (orgs, $localStorage, $log) ->
  $localStorage.favsOrgs ?= {}
  $localStorage.favsOrgs
rslvs.events = (eventsService, $log) ->
  return eventsService.loadEvents()
rslvs.orgs = (events, $log) ->
  orgs = []
  for own k,count of _.countBy(events, 'organizer')
    orgs.push(k) if k and count > 1
  return orgs
rslvs.orgOptions = (orgs, favsOrgs, $log) ->
  ({label: org, selected: !!favsOrgs[org]} for org in orgs)





###Controller###
Ctrl = ($log, $scope, cfg, orgOptions, $localStorage) ->
  vm = @
  $log.log("Instantiating instance of PreferencesFavOrgsCtrl")

  vm.name = "PreferencesFavOrgsCtrl"
  vm.headerTitle = "preferencesFavOrgs"

  $scope.items = orgOptions

  $scope.onItemChanged = (item) ->
    $log.log("setting $localStorage.favOrgs['#{item.label}'] = #{item.selected}")
    $localStorage.favsOrgs[item.label] = item.selected



  # activation fn
  vm.activate = ->
    return

  vm.activate() # run activate fn
  return

###State Config###
stateCfg = {
  url: "/favOrgs"
  resolve: rslvs
  views: "preferences@tab": {
  templateUrl: 'js/states/preferencesFavOrgs.html'
  controller: "PreferencesFavOrgsCtrl as preferencesFavOrgsCtrl"}
  cache: false
}



# ------------------------------Add To App-------------------------------------
gatherNowStates = angular.module('gatherNow.states')
gatherNowStates.controller("PreferencesFavOrgsCtrl", Ctrl)
gatherNowStates.config(($stateProvider) -> $stateProvider.state("tab.preferences.preferencesFavOrgs", stateCfg))
