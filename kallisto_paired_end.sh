#!/bin/bash
# Iterate through a directory of paired-end fastq files and 
# map reads with kallisto
# Note that mapping 218 samples (25 - 30 millions read-pairs in each) took about 17 hours
# on Lenovo S30 thinkstation using 8 threads

# Set transcriptome index path (edit this)
INDEX=$1

# Set number of threads
THREADS=8

# Input directory with FASTQ files (edit this)
FASTQ_DIR=$2

# Output directory
OUT_DIR=$3
mkdir -p "$OUT_DIR"

# Loop through all R1 files
for R1 in "$FASTQ_DIR"/*_R1.fastq.gz; do
    # Get sample prefix (removes _R1.fastq.gz)
    SAMPLE=$(basename "$R1" | sed 's/_R1\.fastq\.gz//')
    SAMPLE_NAME=${SAMPLE##*.}
    echo $SAMPLE_NAME
    
    # Define matching R2 file
    R2="${FASTQ_DIR}/${SAMPLE}_R2.fastq.gz"

    # Check if R2 exists
    if [[ -f "$R2" ]]; then
        echo "Processing $SAMPLE_NAME"

        # Run kallisto
        kallisto quant \
            -b 100 \
            --rf-stranded \
            -i "$INDEX" \
            -o "$OUT_DIR/$SAMPLE_NAME" \
            -t "$THREADS" \
            --plaintext \
            "$R1" "$R2"
    else
        echo "Missing R2 for $SAMPLE_NAME, skipping..."
    fi
done
