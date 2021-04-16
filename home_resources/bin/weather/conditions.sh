#!/bin/bash
curl wttr.in | head -n 3 | tail -n1 | tail --bytes=+31 > /home/sseppal/bin/weather/conditions
