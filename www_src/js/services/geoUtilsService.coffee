###

###

###service name###
name = "geoUtilsService"

###service factory fn###
service = ($log) ->
  $log.log('instantiating #{name}')
  s = {}

  # fast geo distance calculator in km http://stackoverflow.com/questions/27928/how-do-i-calculate-distance-between-two-latitude-longitude-points
  s._distance = (lat1, lng1, lat2, lng2) ->
    R = 6371
    a = (0.5 - Math.cos((lat2 - lat1) * Math.PI / 180)/2 + Math.cos(lat1 * Math.PI / 180) * Math.cos(lat2 * Math.PI / 180) * (1 - Math.cos((lng2 - lng1) * Math.PI / 180))/2)
    return (R * 2 * Math.asin(Math.sqrt(a)))

  ###
    Returns distance between two latlng's in miles
  ###
  s.distance = (latlng1, latlng2) ->
    [lat1, lng1] = [latlng1.lat, latlng1.lng]
    [lat2, lng2] = [latlng2.lat, latlng2.lng]
    return s._distance(lat1, lng1, lat2, lng2) * 0.621371


  return s

# ------------------------------Add To App-------------------------------------
gatherNowServices = angular.module('gatherNow.services')
gatherNowServices.factory(name, service)
