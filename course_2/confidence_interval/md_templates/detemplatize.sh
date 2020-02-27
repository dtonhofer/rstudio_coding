#!/bin/bash

set -o nounset

for file in description.md; do
   template="${file}.template"
   if [[ ! -f $template ]]; then
      echo "No file '$template' -- skipping" >&2
   else
      sed 's/\$WHERE\$/https:\/\/raw.githubusercontent.com\/dtonhofer\/rstudio_coding\/master\/course_2/g' \
      < "$template" > "../$file"
   fi
done





