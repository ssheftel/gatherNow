# Ionic Starter App
# angular.module is a global place for creating, registering and retrieving Angular modules
# 'starter' is the name of this angular module example (also set in a <body> attribute in index.html)
# the 2nd parameter is an array of 'requires'
# 'starter.services' is found in services.js
# 'starter.controllers' is found in controllers.js
gatherNow = angular.module('gatherNow', [
  'ionic'
  'ngCordova'
  'ionic.service.core'
  'ionic.service.push'
  'ionic.service.deploy'
])

###
  Application Config
###
configFn = (ionicAppProvider) ->
  # Identify app
  $ionicAppProvider.identify {
    app_id: '44459d6b'
    api_key: 'bfa4f2bd7a90a18ac41976b2104f31a7664a208f50f32db6'
  }
  return

###
  Main App Run Fn
###
runFn = ($rootScope, $ionicDeploy, $ionicPlatform, $cordovaStatusbar, $log) ->

  onAppReady = ->
    # Hide the accessory bar by default
    if window.cordova and window.cordova.plugins and window.cordova.plugins.Keyboard
      cordova.plugins.Keyboard.hideKeyboardAccessoryBar true

    # Color the iOS status bar text to white
    if window.StatusBar
      $cordovaStatusbar.overlaysWebView true
      $cordovaStatusBar.style 1
      #Light

    # Default update checking
    $rootScope.updateOptions = {interval: (2 * 60 * 1000)}

    # Ionic deploy update checking callback
    updateCb = (hasUpdate) ->
      $rootScope.lastChecked = new Date()
      $log.log('WATCH RESULT', hasUpdate)
      return

    # Watch Ionic Deploy service for new code
    $ionicDeploy.watch($rootScope.updateOptions).then( (->), (->), updateCb)

    return

  $ionicPlatform.ready(onAppReady)

  return

# -----------------------------------------------------------------------------

gatherNow.config(['$ionicAppProvider', configFn])
gatherNow.run(runFn)
