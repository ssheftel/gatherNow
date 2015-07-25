#!/bin/sh

set -e

# cleanup
rm -rf platforms/
rm -rf plugins/

### Added 7/24/15 get dir path to script###
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null

read -p "Which platforms do you want to build? (android ios): " platforms
platforms=${platforms:-"android ios"}

# install platforms and plugin
echo "installing platforms "$platforms
cordova platform add $platforms

# reinstall specific plugins
#cordova plugin add https://github.com/Wizcorp/phonegap-facebook-plugin.git --variable APP_ID="$FACEBOOK_APP_ID" --variable APP_NAME="$FACEBOOK_APP_NAME"
#cordova plugin add plugin.google.maps --variable API_KEY_FOR_ANDROID="$GMAPS_API_KEY_FOR_ANDROID" --variable API_KEY_FOR_IOS="$GMAPS_API_KEY_FOR_IOS"
cordova plugin add $SCRIPTPATH/cached_plugins/phonegap-facebook-plugin --variable APP_ID="$FACEBOOK_APP_ID" --variable APP_NAME="$FACEBOOK_APP_NAME"
cordova plugin add $SCRIPTPATH/cached_plugins/phonegap-googlemaps-plugin --variable API_KEY_FOR_ANDROID="$GMAPS_API_KEY_FOR_ANDROID" --variable API_KEY_FOR_IOS="$GMAPS_API_KEY_FOR_IOS"
cordova plugin add org.apache.cordova.splashscreen
cordova plugin add $SCRIPTPATH/cached_plugins/Calendar-PhoneGap-Plugin
#cordova plugin add $SCRIPTPATH/cached_plugins/cordova-plugin-background-geolocation
#
cordova plugin add org.apache.cordova.device
cordova plugin add org.apache.cordova.device-motion
cordova plugin add org.apache.cordova.device-orientation
cordova plugin add org.apache.cordova.geolocation
cordova plugin add org.apache.cordova.console
cordova plugin add com.ionic.keyboard
cordova plugin add org.apache.cordova.inappbrowser
