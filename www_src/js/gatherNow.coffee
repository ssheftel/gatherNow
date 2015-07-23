# Ionic Starter App
# angular.module is a global place for creating, registering and retrieving Angular modules
# 'starter' is the name of this angular module example (also set in a <body> attribute in index.html)
# the 2nd parameter is an array of 'requires'
# 'starter.services' is found in services.js
# 'starter.controllers' is found in controllers.js

###
  Creates the gatherNow main app module
###
angular.module('gatherNow', [
  'ionic'
  'ngCordova'
  'ionic.service.core'
  'ionic.service.push'
  'ionic.service.deploy'
  # Third Party
  'angular.filter'
  'angularMoment'
  'ngStorage'
  #My Modules
  'gatherNow.models'
  'gatherNow.services'
  'gatherNow.filters'
  'gatherNow.directives'
  'gatherNow.states'
])
