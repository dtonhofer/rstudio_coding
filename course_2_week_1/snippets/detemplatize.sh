#!/bin/bash

out=sample_stats_plot_ames.md
in=${out}.template

if [[ ! -f $in ]]; then
   echo "No file '$in' -- exiting" >&2
   exit 1
fi

sed 's/\$WHERE\$/https:\/\/raw.githubusercontent.com\/dtonhofer\/rstudio_coding\/master\/course_2_week_1\/plots/g' < "$in" > "$out"




