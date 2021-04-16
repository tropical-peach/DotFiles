#!/bin/bash
curl wttr.in | head -n 4 | tail -n1 | tail --bytes=+42 > /home/sseppal/bin/weather/temperature 
sed --in-place 's/[\x01-\x1F\x7F]//g' /home/sseppal/bin/weather/temperature 
sed --in-place 's/\[0m//g' /home/sseppal/bin/weather/temperature 
