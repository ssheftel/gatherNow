###
  Tabs State Configuration
###

# -------------------------------Template--------------------------------------

tpl = """
<ion-tabs class="tabs-icon-top tabs-color-active-positive">

  <!-- START EVENTS TAB -->
  <ion-tab title="Events" icon-off="ion-ios-calendar-outline" icon-on="ion-ios-calendar" ui-sref="tab.events">
    <ion-nav-view name="events"></ion-nav-view><!-- "events" named view -->
  </ion-tab>
  <!-- END EVENTS TAB -->

  <!-- START MAP TAB -->
  <ion-tab title="Map" icon-off="ion-ios-navigate-outline" icon-on="ion-ios-navigate" ui-sref="tab.map">
    <ion-nav-view name="map"></ion-nav-view><!-- "map" named view -->
  </ion-tab>
  <!-- END MAP TAB -->

  <!-- START PREFERENCES TAB -->
  <ion-tab title="Preferences" icon-off="ion-ios-gear-outline" icon-on="ion-ios-gear" ui-sref="tab.preferences">
    <ion-nav-view name="preferences"></ion-nav-view><!-- "preferences" named view -->
  </ion-tab>
  <!-- END PREFERENCES TAB -->

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
