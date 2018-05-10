#!/bin/bash

# note that wineboot fails if DISPLAY is set to anything before it is run!
DISPLAY= wineboot --init

Xvfb :0 -screen 0 1024x768x16 &
DISPLAY=:0 winetricks -q vcrun2008 vcrun2010

DISPLAY= wineboot -e
DISPLAY= wineboot -s
