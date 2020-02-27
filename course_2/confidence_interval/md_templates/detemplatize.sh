#!/bin/bash

set -o nounset

for file in description.md; do
   template="${file}.template"
   if [[ ! -f $template ]]; then
      echo "No file '$template' -- skipping" >&2
   else
      # Use tilde instead of "/" as separator
      raw="https://raw.githubusercontent.com/dtonhofer/rstudio_coding/master"
      blob="https://github.com/dtonhofer/rstudio_coding/blob/master"
      cat "$template" | \
        sed "s~%DIAGRAMS%~${raw}/course_2/confidence_interval/diagrams~g" | \
        sed "s~%PLOTS%~${raw}/course_2/confidence_interval/plots~g" | \
        sed "s~%CODE%~${blob}/course_2/confidence_interval/code~g" \
      > "../$file"
   fi
done





