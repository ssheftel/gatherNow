###
  Configuration of Cordova and ngCordova plugins
###

# ------------------------------Main Code--------------------------------------

###
  Set default options for the InAppBrowser
###
globalInAppBrowserConfig = ($cordovaInAppBrowserProvider) ->
  #Note not sure this is actualy working
  defaultOptions =
    location: 'yes'
    clearcache: 'yes'
    toolbar: 'yes'
  ionic.Platform.ready ->
    $cordovaInAppBrowserProvider.setDefaultOptions(defaultOptions)
  return

# ------------------------------Add To App-------------------------------------
gatherNow = angular.module('gatherNow')
gatherNow.config(globalInAppBrowserConfig)
