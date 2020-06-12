#!/bin/bash

# First obtain a location code from: https://weather.codes/search/

# Insert your location. For example LOXX0001 is a location code for Bratislava, Slovakia
location="LOXX0001"
tmpfile=/tmp/$location.out

# Obtain sunrise and sunset raw data from weather.com
wget -q "https://weather.com/weather/today/l/$location" -O "$tmpfile"

SUNR=$(grep -o '<p class="_-_-components-src-molecule-SunriseSunset-SunriseSunset--dateValue--3H780">.*am</p>' "$tmpfile" | grep -o '>.*</p>' | cut -c 2- | rev | cut -c5- | rev)
SUNS=$(grep -o '<p class="_-_-components-src-molecule-SunriseSunset-SunriseSunset--dateValue--3H780">.*pm</p>' "$tmpfile" | grep -o '>.*</p>' | cut -f10,1 -d'>' | cut -c2- | rev | cut -c4- | rev)

sunrise=$(date --date="$SUNR" +%R)
sunset=$(date --date="$SUNS" +%R)

# Use $sunrise and $sunset variables to fit your needs. Example:
echo "Sunrise for location $location: $sunrise"
echo "Sunset for location $location: $sunset"
