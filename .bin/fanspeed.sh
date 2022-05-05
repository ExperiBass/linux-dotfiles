#!/bin/sh

sensors | grep -E "fan" | tr "\n" " " | awk '{printf " %.0f", ($2+$13)/2}' 
