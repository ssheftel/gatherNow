###General Application Config###

# ------------------------------Main Code--------------------------------------

ionicAppIoServiceCfg = ($ionicAppProvider) ->
  #Identify app
  $ionicAppProvider.identify {
    app_id: '44459d6b'
    api_key: 'bfa4f2bd7a90a18ac41976b2104f31a7664a208f50f32db6'
  }
  return

# ------------------------------Add To Angular---------------------------------

gatherNow = angular.module('gatherNow')
gatherNow.config(ionicAppIoServiceCfg)
