#!/bin/bash

# imagemagick
identify image.jpg
convert -strip -interlace Plane -gaussian-blur 0.05 -quality 85% source.jpg result.jpg
convert in.jpg -geometry 1920x1080^ -gravity center -crop 1920x1080+0+0 out.jpg
# create 32x32 with white background
convert -size 32x32 xc:white empty.jpg
# create 32x32 with transparent background
convert -size 32x32 xc:transparent empty.jpg

# mediainfo
mediainfo *.mkv | egrep --color -i 'complete name|format|format version|file size|duration|overall bit rate|width|height|codec id'

# artillery (stress testing)
npm install -g artillery
artillery -V
artillery quick --count 10 -n 20 http://localhost

# filebot (media organizer)
filebot -rename ./ --db thetvdb -non-strict --action test
filebot -rename ./ --db thetvdb -non-strict --action move --format "{s00e00} - {t}"
filebot -rename ./ --db thetvdb -no-xattr -non-strict --action move --format "../../TV Series/{n}/{s00e00} - {t}"
filebot -rename ./ -r --db thetvdb -non-strict --action test --format '/media/sf_dionysus_d/Sorted/TV Shows/{n}/{s00e00} - {t}' | awk '{
if ($1 ~ /TEST|MOVE|Skipped/)
    {
        print "\033[34m" $1 "\033[0m";
        $1="";
        gsub("\\\\DESKTOP-IAF0G9Q","");
        gsub("because","\n   because");
        gsub("to","\n   to");
        print "  " $0;
    }
else
    {
        print $0;
    }
}'

filebot -rename ./ -r --db thetvdb -no-xattr -non-strict --action test --format '/mnt/e/Sorted/{n}/{s00e00} - {t}'

# webpagetest
webpagetest locations
webpagetest test https://onemission.fund/support/ --location SanJose_IE9 --key A.37fbb0d3ae6ad503d8359acc7afd7215 --poll 5
webpagetest status <test_id>
webpagetest results <test_id>
webpagetest waterfall <test_id> # get the waterfall PNG image
# screenshot, video, netlog, request

