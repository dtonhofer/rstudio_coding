#!/bin/bash

in=description.md.template
out=description.md

if [[ ! -f $in ]]; then
   echo "No file '$in' -- exiting" >&2
   exit 1
fi

sed 's/\$WHERE\$/https:\/\/raw.githubusercontent.com\/dtonhofer\/rstudio_coding\/master\/confidence_interval/g' < "$in" > "$out"




