#!/bin/bash

set -o nounset

raw_master="https://raw.githubusercontent.com/dtonhofer/rstudio_coding/master"
blob_master="https://github.com/dtonhofer/rstudio_coding/blob/master"
 
for file in plot_pdf_of_area.md sample_stats_plot_ames.md; do
   template="${file}.template"
   if [[ ! -f $template ]]; then
      echo "No file '$template' -- skipping" >&2
   else
      # Use tilde instead of "/" as separator
      useful="$blob_master/course_2/useful"
      plots="$raw_master/course_2/course_2_week_1/plots"
      cat "$template" | \
        sed "s~%USEFUL%~${useful}~g" | \
        sed "s~%PLOTS%~${plots}~g" \
      > "../$file"
   fi
done


