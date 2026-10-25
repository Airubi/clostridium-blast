# Clostridium BLASTN Pipeline

A reproducible Bash workflow for nucleotide sequence similarity searches using NCBI BLAST+.

## Project status

This project is under development. The current query is a 500 bp segment extracted from the reference genome and is used to test the workflow, not to claim a biological discovery.

## Reference genome

- Organism: Clostridium beijerinckii NCIMB 8052
- NCBI accession: [NC_009617.1](https://www.ncbi.nlm.nih.gov/nuccore/NC_009617.1)

## Requirements

- Linux or WSL
- NCBI BLAST+ (makeblastdb, blastn, blastdbcmd)
- Bash

## Usage

1. Build the database: `bash scripts/build_db.sh`
2. Place query FASTA files in `query_seq/`.
3. Run the search: `bash scripts/run_blast.sh`
4. Results are written under `results/result_blast_loop/`.

## Identity thresholds

The pipeline runs BLASTN using minimum percent-identity thresholds of 50, 60, 70, 80, and 90.

## Limitations

The current database contains one reference genome. The test query comes from that same genome, so a 100% match is expected. This is a technical pipeline test, not a biological discovery.

## Reproducibility

Rebuild the database with `scripts/build_db.sh`, then run `scripts/run_blast.sh`.
