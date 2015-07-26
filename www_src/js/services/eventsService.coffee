###
  Events Service
###

name = "eventsService"

service = ($log, $http, $q, cfg, EventModel) ->
  $log.log("creating #{name}")
  s = {}


  s.events = []
  s._url = "#{cfg.api}/events"
  s._defaultQueryParams =
    max_results: 200
    sort: 'start_date'
    where: """{"start_date": {"$gte": "#{new Date().toISOString()}"}}"""

  s.loadEvents = (queryParams=s._defaultQueryParams) ->
    $log.log("requesting events with queryParams of #{angular.toJson(queryParams)}")
    if s.events.length > 0
      $log.log("Warning: #{name}.loadEvents was called but events already loaded")
      return $q.when(s.events)
    $http.get(s._url, params: queryParams)
      .then (resp) ->
        for event in resp?.data?._items

          s.events.push new EventModel(event)
        return s.events

  s.getEvents = -> s.events

  s._eventsWithinNDaysFilerFactory = (eventsWithinTheNextNDays) ->
    now = moment()
    startOfTomorrow = moment().add(eventsWithinTheNextNDays, 'day').startOf('day')
    filter = (event) ->
      return event.start_moment.isBefore(startOfTomorrow) and event.end_moment.isAfter(now)
    return filter

  s._filterEvents = (filter) ->
    eventsSubset = []
    for event in s.events
      continue if not event.start_moment or not event.end_moment
      if filter(event)
        eventsSubset.push(event)
    eventsSubset

  s.todaysEvents = ->
    filter = s._eventsWithinNDaysFilerFactory(1)
    return s._filterEvents(filter)

  s.nextSevenDaysEvents = ->
    filter = s._eventsWithinNDaysFilerFactory(7)
    return s._filterEvents(filter)

  s.nextThirtyDaysEvents = ->
    filter = s._eventsWithinNDaysFilerFactory(30)
    return s._filterEvents(filter)

  return s

# ------------------------------Add To App-------------------------------------
gatherNowServices = angular.module('gatherNow.services')
gatherNowServices.factory(name, service)
