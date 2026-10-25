#!/bin/bash

set -euo pipefail

# Database
DB="./Blastdb/Clostridium_genomes"

# Query folder
QUERY_DIR="./query_seq"

# Result folder
RESULT_DIR="./results/result_blast_loop"
mkdir -p "$RESULT_DIR"

# Identity thresholds
IDENTITIES=(50 60 70 80 90)

# Check database
blastdbcmd -db "$DB" -info >/dev/null

# Check query files
shopt -s nullglob
QUERIES=("$QUERY_DIR"/*.fasta)

if [ ${#QUERIES[@]} -eq 0 ]; then
    echo "ERROR: No FASTA files found in $QUERY_DIR"
    exit 1
fi

# Process each query
for QUERY in "${QUERIES[@]}"; do
    QNAME=$(basename "$QUERY" .fasta)

    echo "Processing query: $QNAME"

    QUERY_RESULT_DIR="$RESULT_DIR/$QNAME"
    mkdir -p "$QUERY_RESULT_DIR"

    for ID in "${IDENTITIES[@]}"; do
        echo "Running BLASTN: $QNAME, identity >= $ID%"

        OUT_FILE="$QUERY_RESULT_DIR/${QNAME}_perc${ID}_blast.tsv"

        blastn \
            -query "$QUERY" \
            -db "$DB" \
            -out "$OUT_FILE" \
            -outfmt 6 \
            -perc_identity "$ID" \
            -max_target_seqs 5000 \
            -evalue 1e-10

        echo "Saved: $OUT_FILE"
    done
done

echo "All queries processed."
