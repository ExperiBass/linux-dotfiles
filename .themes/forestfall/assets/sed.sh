#!/bin/sh
sed -i \
         -e 's/#271424/rgb(0%,0%,0%)/g' \
         -e 's/#DBB28D/rgb(100%,100%,100%)/g' \
    -e 's/#271424/rgb(50%,0%,0%)/g' \
     -e 's/#5F547B/rgb(0%,50%,0%)/g' \
     -e 's/#271424/rgb(50%,0%,50%)/g' \
     -e 's/#DBB28D/rgb(0%,0%,50%)/g' \
	"$@"