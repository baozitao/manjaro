#!/bin/bash

killall -q polybar

while pgrep $UID -x polybar > /dev/null; do sleep 1; done
polybar example &
echo "Polybar runing..."

