#!/bin/bash

for file in plot_pdf_of_area.md sample_stats_plot_ames.md; do
   template="${file}.template"
   if [[ ! -f $template ]]; then
      echo "No file '$template' -- skipping" >&2
   else
      sed 's/\$WHERE\$/https:\/\/raw.githubusercontent.com\/dtonhofer\/rstudio_coding\/master\/course_2\/course_2_week_1\/plots/g' \
      < "$template" > "../$file"
   fi
done





