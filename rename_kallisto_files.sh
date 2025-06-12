#!/bin/bash
# Loop through directories with kallisto results files
# and rename these files to the directory names.
# We assume that directory names are sample names.
# This simplifies further processing of kallisto output, like
# differential expression analysis

# Loop through all subdirectories
for dir in ./*/; do
  # Remove trailing slash to get the sample name
  sample="${dir%/}"
  sample=${sample#./}
  echo $sample

  # Paths to original files
  abundance_file="${dir}abundance.tsv"
  runinfo_file="${dir}run_info.json"

  # Check if both files exist
  if [[ -f "$abundance_file" && -f "$runinfo_file" ]]; then
    echo "Renaming files in $sample"

    mv "$abundance_file" "${dir}${sample}_abundance.tsv"
    mv "$runinfo_file" "${dir}${sample}_run_info.json"
  else
    echo "Warning: $sample does not contain expected Kallisto output files"
  fi
done
