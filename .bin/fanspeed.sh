#!/bin/sh

OUTPUT=`sensors | grep -E "fan"`

echo $OUTPUT | awk '{print $2 " RPM, " $13 " RPM"}'
