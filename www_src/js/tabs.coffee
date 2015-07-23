###
  Tabs State Configuration
###

# -------------------------------Template--------------------------------------

tpl = """
<ion-tabs class="tabs-icon-top tabs-background-dark tabs-color-stable">

  <!-- START EVENTS TAB -->
  <ion-tab title="Events" icon-off="ion-ios-ionic-outline" icon-on="ion-ionic" href="#/tab/events">
    <ion-nav-view name="events"></ion-nav-view><!-- "events" named view -->
  </ion-tab>
  <!-- END EVENTS TAB -->

</ion-tabs>
"""

# ------------------------------Controller-------------------------------------

ctrlName = 'TabsCtrl'
ctrlInstName = s.decapitalize(ctrlName)

TabsCtrl = ($log, $scope, cfg) ->
  vm = @
  $log.log("Instantiating instance of #{ctrlName}")

  vm.name = ctrlName

  return

# -----------------------------Resolve Functions-------------------------------

rslvs = {}

# -------------------------------State Config----------------------------------

stateName = 'tab'

tabsCfg = {
  name: stateName
  url: '/tab'
  abstract: true
  template: tpl
  controller: "#{ctrlName} as #{ctrlInstName}"
  resolve: rslvs
}

# ------------------------------Add To App-------------------------------------

gatherNow = angular.module('gatherNow')
gatherNow.controller(ctrlName, TabsCtrl)
gatherNow.config(($stateProvider) -> $stateProvider.state(tabsCfg);return;)
