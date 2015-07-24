###
  Application Constants - cfg stands for config
###

# ------------------------------Main Code--------------------------------------

constantName = 'cfg'

cfg = {
  "api": "https://gather-now-service.herokuapp.com"

}

# ------------------------------Add To App-------------------------------------
gatherNow = angular.module('gatherNow')
gatherNow.constant(constantName, cfg)
