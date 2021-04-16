#!/bin/bash
curl wttr.in | head | grep mph | tail -c 41  > /home/sseppal/bin/weather/windspeed
sed --in-place 's/[\x01-\x1F\x7F]//g' /home/sseppal/bin/weather/windspeed
sed --in-place 's/\[0m//g' /home/sseppal/bin/weather/windspeed 
sed --in-place -e 's/\[.*[[:digit:]]m\s*\(.*\)/\1/' /home/sseppal/bin/weather/windspeed
