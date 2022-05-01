#!/bin/sh

sensors | grep -E "fan" | awk '{print ($2+$13)/2 " RPM"}' 
