#!/bin/bash
# Summarize kallisto run_info.json file
# Requires jq as a dependency

echo -e "Sample\tReadsProcessed\tPseudoaligned\tPseudoalign(%)\tUniqueReads\tUnique(%)"

# Loop through all run_info.json files in subdirectories
for json in ./*.json; do
    # Extract sample name from directory
    sample=`basename $json`
    sample=${sample%_run_info.json}
    
    # Use jq to extract fields
    n_proc=$(jq .n_processed "$json")
    n_pseudo=$(jq .n_pseudoaligned "$json")
    p_pseudo=$(jq .p_pseudoaligned "$json")
    n_unique=$(jq .n_unique "$json")
    p_unique=$(jq .p_unique "$json")

    echo -e "${sample}\t${n_proc}\t${n_pseudo}\t${p_pseudo}\t${n_unique}\t${p_unique}"
done
