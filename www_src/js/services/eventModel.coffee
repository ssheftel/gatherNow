###
  Model Class for wrapping the events data
###

name = "EventModel"

service = ($log) ->

  class EventModel
    constructor: (event) ->
      angular.extend(@, event)
      @start_moment = moment(@start_date)
      @end_moment = moment(@end_date)
      @latlng = {lat:@geo.coordinates[1], lng:@geo.coordinates[0]} if @geo


  return EventModel

# ------------------------------Add To App-------------------------------------
gatherNowServices = angular.module('gatherNow.services')
gatherNowServices.factory(name, service)
