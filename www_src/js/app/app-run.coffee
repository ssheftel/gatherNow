###Application Run Phase Logic###
gatherNow = angular.module('gatherNow')

# ------------------------------Main Code--------------------------------------

splashScreenTimerRunFn = ($log, $timeout, $cordovaSplashscreen, eventsService) ->
  $log.log('getting events data, will hide splash screen after promise resolves')
  hideSplashScreen = ->
    $log.log('hiding splash screen')
    $cordovaSplashscreen.hide()
    return
  ###TODO: handel when user has no internet connection###
  eventsService.loadEvents().finally(hideSplashScreen )
  $timeout( hideSplashScreen, 5 * 1000)

runFn = ($rootScope, $ionicDeploy, $ionicPlatform, $log) ->


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
    #$ionicDeploy.watch($rootScope.updateOptions).then( (->), (->), updateCb)

    return

  $ionicPlatform.ready(onAppReady)

  return

noInternetConnectionWarning = ($ionicPlatform, $ionicPopup) ->
  onAppReady = ->
    #todo change this to a state
    popupConfig =
      title: "Internet Disconnected"
      content: "The internet is disconnected on your device."
    exitApp = -> ionic.Platform.exitApp()#not working
    if window.Connection and navigator.connection.type == Connection.NONE
      $ionicPopup.confirm(popupConfig).then (result) -> exitApp() if not result
    return
  $ionicPlatform.ready(onAppReady)
# ------------------------------Add To App-------------------------------------

gatherNow.run(splashScreenTimerRunFn)
gatherNow.run(runFn)
gatherNow.run(noInternetConnectionWarning)
