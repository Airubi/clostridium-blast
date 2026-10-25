#!/usr/bin/env bash

set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_DIR"

GENOME="genomes/Clostridium_beijerinckii_NCIMB8052.fasta"
DB_DIR="Blastdb"
DB_PREFIX="$DB_DIR/Clostridium_genomes"

if ! command -v makeblastdb >/dev/null 2>&1; then
    echo "ERROR: makeblastdb was not found."
    echo "Install NCBI BLAST+ before continuing."
    exit 1
fi

if [[ ! -s "$GENOME" ]]; then
    echo "ERROR: Genome FASTA is missing or empty: $GENOME"
    exit 1
fi

mkdir -p "$DB_DIR"

echo "Building nucleotide BLAST database..."
makeblastdb \
    -in "$GENOME" \
    -dbtype nucl \
    -parse_seqids \
    -out "$DB_PREFIX"

echo
echo "Checking the generated database..."
blastdbcmd -db "$DB_PREFIX" -info

echo
echo "Database build completed successfully."
