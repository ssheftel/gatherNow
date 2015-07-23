###
  Events State Config - Events List index state of events
###

stateName = 'events'
tabName = "#{stateName}" # derived - will be different for nested child states

###Derived and Defaulted Variables###
parentStates = ['tab'] # should be '' if no parent
url = "/#{stateName}" # derived - but may need to change
ctrlName = "#{s.capitalize(stateName)}Ctrl"# 'EventDetailsCtrl'
ctrlInstName = s.decapitalize(ctrlName)
stateNamePrefix = parentStates.join('.')
fullStateName = "#{stateNamePrefix}.#{stateName}"

###Template###
tpl = """
<ion-view view-title="{{ #{ctrlInstName}.headerTitle }}">
  <ion-content class="padding">
    <ion-list>
      <ion-item ng-repeat="item in #{ctrlInstName}.events">
        <a class="item item-thumbnail-left" ui-sref="tab.events.eventDetails({eventId: item._id})"> <!--ng-class="{'item-thumbnail-left': item.image_url}"-->
          <img ng-src="{{item.image_url || 'http://www.gatherthejews.com/wp-content/uploads/2015/03/gather_the_jews_rectangle.png'}}">
          <h2>{{item.title}}</h2>
          <h3>{{item.start_date | amDateFormat:'dddd, MMMM Do YYYY, h:mm:ss a'}}</h3>
        </a>
      </ion-item>
    </ion-list>
    <!--<a ui-sref="tab.events.eventDetails({eventId:10})">to details</a>-->
    <ion-infinite-scroll
      on-infinite="#{ctrlInstName}.loadMore()"
      distance="5%">
    </ion-infinite-scroll>
  </ion-content>
</ion-view>
"""

###Resolve Functions###
rslvs = {}
rslvs.events = ($http) ->
  return $http.get('https://gather-now-service.herokuapp.com/events')
    .then (resp) -> resp.data


###Controller###
Ctrl = ($log, $scope, cfg, $state, events, $http) ->
  vm = @
  $log.log("Instantiating instance of #{ctrlName}")

  vm.name = ctrlName
  vm.headerTitle = 'Upcoming Events'
  vm.events = events._items
  window.$state = $state
  page=1
  vm.loadMore = ->
    page += 1
    $http.get('https://gather-now-service.herokuapp.com/events', params:{'page':page})
      .then (resp) ->
        for newItem in resp.data['_items']
          vm.events.push(newItem)
        $scope.$broadcast('scroll.infiniteScrollComplete')
        return
    return

  return

###State Config###
stateCfg = {
  url: url
  resolve: rslvs
  views: "#{tabName}@tab": {
  template: tpl
  controller: "#{ctrlName} as #{ctrlInstName}"}
}



# ------------------------------Add To App-------------------------------------
gatherNowStates = angular.module('gatherNow.states')
gatherNowStates.controller(ctrlName, Ctrl)
gatherNowStates.config(($stateProvider) -> $stateProvider.state(fullStateName, stateCfg);return;)
