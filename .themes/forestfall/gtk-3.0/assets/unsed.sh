#!/bin/sh
sed -i \
         -e 's/rgb(0%,0%,0%)/#271424/g' \
         -e 's/rgb(100%,100%,100%)/#DBB28D/g' \
    -e 's/rgb(50%,0%,0%)/#271424/g' \
     -e 's/rgb(0%,50%,0%)/#5F547B/g' \
 -e 's/rgb(0%,50.196078%,0%)/#5F547B/g' \
     -e 's/rgb(50%,0%,50%)/#271424/g' \
 -e 's/rgb(50.196078%,0%,50.196078%)/#271424/g' \
     -e 's/rgb(0%,0%,50%)/#DBB28D/g' \
	"$@"