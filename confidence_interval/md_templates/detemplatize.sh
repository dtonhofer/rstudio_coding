#!/bin/bash

set -o nounset

raw_master="https://raw.githubusercontent.com/dtonhofer/rstudio_coding/master"
blob_master="https://github.com/dtonhofer/rstudio_coding/blob/master"
 
for file in README.md; do
   template="${file}.template"
   if [[ ! -f $template ]]; then
      echo "No file '$template' -- skipping" >&2
   else
      # Use tilde instead of "/" as separator
      cat "$template" | \
        sed "s~%DIAGRAMS%~${raw_master}/confidence_interval/diagrams~g" | \
        sed "s~%PLOTS%~${raw_master}/confidence_interval/plots~g" | \
        sed "s~%CODE%~${blob_master}/confidence_interval/code~g" \
      > "../$file"
   fi
done

