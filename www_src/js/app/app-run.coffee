###Application Run Phase Logic###
gatherNow = angular.module('gatherNow')

# ------------------------------Main Code--------------------------------------

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

# ------------------------------Add To App-------------------------------------

gatherNow.run(runFn)
